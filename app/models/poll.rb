class Poll < ActiveRecord::Base
  scope :featured, where(:featured => true)

  attr_accessor :question_reformat

  attr_accessible :question, :coverage, :yes, :no, :country_code, :user_id, :description

  validates_presence_of :user_id, :question, :country_code, :coverage
  validates_uniqueness_of :question

  has_many :ballots
  
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
  
  def ballot_complex(current_user_id, last_ballot_at, n = 15)
    no_more = false
    complex = []
    index = 0
    
    cond =  last_ballot_at.blank? ? '1 == 1' : ['ballots.updated_at < ?', Time.at(last_ballot_at.to_f)] 
    
    all = self.ballots.where(cond).order('updated_at DESC')
    
    # NOTE not user >=, since when in case no rationale, needs to stay on 'n' to load all of them
    until complex.size > n || index > all.size - 1
      # ballot has an explanation or is from the current user
      if all[index].answer.present? || all[index].user_id == current_user_id
        break if complex.size >= n # break the block when complex is full, necessary see the NOTE
        complex << all[index]
      else
        # if complex is empty or a ballot with answer was just inserted,
        # create a placeholder for all later ballots with not answers
        complex << { all[index].vote => Array.new } if complex.blank? || complex.last.kind_of?(Ballot) || complex.last.keys[0] != all[index].vote
        complex.last.values[0] << all[index]
      end
      
      index += 1
    end
    
    no_more = true if index >= all.size - 1 #all ballots have been checked, so there is no more to load
    
    return complex.first(n), no_more
  end
end
