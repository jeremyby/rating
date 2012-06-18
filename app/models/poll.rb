class Poll < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessor :question_reformat
  
  validates_presence_of :user_id, :question, :country_code, :category, :coverage, :weight
  
  has_many    :votings
  
  belongs_to  :country,   :foreign_key => "country_code",     :primary_key => "code",     :counter_cache => true
  belongs_to  :owner,     :foreign_key => "user_id",          :class_name => "User"
  
  extend FriendlyId
  friendly_id :question_reformat, :use => :slugged
  
  def default_format?
    self.positive == "Yes" && self.negative == "No"
  end
  
  def question_positive?
    self.positive.blank?
  end
  
  def question_reformat
    q = String.new(self.question)

    return q.split.take(10).join(" ").downcase.tr("^a-z|^0-9|^\s", "")
  end
end
