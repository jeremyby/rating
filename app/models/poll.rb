class Poll < ActiveRecord::Base
  scope :approved, where("weight > 0")
  scope :featured, where(:featured => true)

  attr_accessor :question_reformat

  attr_accessible :question, :category, :coverage, :yes, :no, :country_code, :weight, :user_id, :description

  validates_presence_of :user_id, :question, :country_code, :category, :coverage, :weight
  validates_uniqueness_of :question
  validates_exclusion_of :category, :in => %w( nil ), :message => "need to be a valid category"

  has_many :votings
  
  has_many :followings, :as => :followable, :dependent => :destroy
  has_many :followers, :through => :followings, :source => :user

  belongs_to  :country,   :foreign_key => "country_code",     :primary_key => "code",     :counter_cache => true
  belongs_to  :owner,     :foreign_key => "user_id",          :class_name => "User"

  extend FriendlyId
  friendly_id :question_reformat, :use => :slugged

  acts_as_commentable

  def question_reformat
    q = String.new(self.question)

    return q.split[0..9].join(" ").downcase.tr("^a-z|^0-9|^\s", "")
  end

  def assign_attributes(values, options = {})
    sanitize_for_mass_assignment(values, options[:as]).each do |k, v|
      send("#{k}=", v)
    end
  end


  #********************************************
  #
  #   Business Logic
  #
  #********************************************
  
  def more_polls(limit = 4)
    Poll.where("country_code = ? AND id is NOT ?", self.country_code, self.id).order("RANDOM()").limit(limit)
  end
  
  def simple?
    self.yes == 'Yes' && self.no == 'No'
  end
  
  def or_negative?
    self.yes == 'Yes' && self.no != 'No'
  end
  
  def to_s
    self.question
  end
  
  def voting_complex(current_user_id, last_voting_at = 0, n = 10)
    complex = []
    index = 0
    
    all = self.votings.where('votings.updated_at > ?', last_voting_at).order('updated_at DESC')
    
    # NOTE not user >=, since when in case no rationale, needs to stay on 'n' to load all of them
    until complex.size > n || index > all.size - 1
      # voting has an explanation or is from the current user
      if all[index].explain.present? || all[index].user_id == current_user_id
        break if complex.size >= n # break the block when complex is full, necessary see the NOTE
        complex << all[index]
      else
        # if complex is empty or an explained voting was just inserted,
        # create a placeholder for all non-rationaled votings
        complex << { all[index].vote => Array.new } if complex.blank? || complex.last.kind_of?(Voting) || complex.last.keys[0] != all[index].vote
        complex.last.values[0] << all[index]
      end
      
      index += 1
    end
    
    return complex.first(n)
  end
end
