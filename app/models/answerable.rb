class Answerable < ActiveRecord::Base
  scope :ballots, where(:type => 'Ballot')
  scope :answers, where(:type => 'Answer')
  
  attr_accessible :askable_id, :country_code, :vote, :body
  
  after_create :log_create, unless: 'self.body.blank?'
  after_update :log_update, unless: 'self.body.blank?'
  
  validates_presence_of :askable_id, :user_id, :country_code
  validates_uniqueness_of :askable_id, :scope => [:country_code, :user_id]
  
  validates :vote, 
    presence: true, 
    inclusion: { in: [1, -1] },
    if: Proc.new { |a| a.type == 'Ballot' }
      
  validates :body, length: {
      :maximum   => 3000,
      :too_long  => I18n.t('errors.messages.too_long')
    }, if: Proc.new { |a| a.type == 'Ballot' }
      
  validates :body, length: {
      :minimum   => 3,
      :maximum   => 3000,
      :too_short => I18n.t('errors.messages.too_short'),
      :too_long  => I18n.t('errors.messages.too_long')
    }, if: Proc.new { |a| a.type == 'Answer' }
  
  belongs_to :askable
  belongs_to :user
  belongs_to :country,          :foreign_key => "country_code",     :primary_key => "code"
  
  has_many :events, :dependent => :destroy
  
  translates :body, :auto_translated, :versioning => true 
  
  acts_as_translateable
  acts_as_commentable
  
  def translate(from, to, is_update = false)
    doc = Nokogiri::HTML(self.body)
    
    # only translates certain all support texts, except href/text, image/alt
    elements = doc.xpath('//h2/text()', '//h3/text()', '//p/text()', '//span/text()', '//em/text()', '//strong/text()', '//s/text()', '//li/text()', '//pre/text()')
    
    objs = elements.map { |e| e.content.gsub(/[\n\r\t]/, '').blank? ? nil : e }.compact
  
    result = EasyTranslate.translate(objs.map {|o| o.content.gsub(/[\n\r\t]/, '') }, from: from, to: to)
    
    objs.each_with_index do |o, i|
      o.content = HTMLCoder.decode(result[i])
    end
    
    self.transaction do
      I18n.with_locale(to) do
        self.body = doc.css('body').children.to_html
        self.auto_translated = true

        self.save!
      end
      
      self.add_locale_to_event(to) unless is_update
    end
  end
  
  private
  def log_create
    # when a user answers a question or in a poll
    self.events.create(
      :kind => 'answer',
      :user_id => self.user_id,
      :country_code => self.country_code,
      :askable_id => self.askable_id,
      :locales => I18n.locale.to_s
    )
  end
  
  def log_update
    event = Event.find_by_answerable_id(self.id)
    
    if event.blank?
      self.log_create
    else
      event.update_attribute('updated_at', Time.now)
    end
  end
end