class User < ActiveRecord::Base
  include ActiveModel::MassAssignmentSecurity
  
  attr_accessor :password_confirmation
  
  before_save :process_names
  
  
  attr_accessible :first_name, :last_name, :email, :country_code, :password, :password_confirmation, :avatar
  
  belongs_to  :country,               :foreign_key => 'country_code',     :primary_key => 'code'
  has_many :authorizations,           :dependent => :destroy
  
  has_many :watchings, :dependent => :destroy
  has_many :watching_countries, :through => :watchings
  
  has_many :polls
  has_many :votings, :dependent => :destroy
  
  acts_as_authentic do |c|
    c.ignore_blank_passwords = true #ignoring passwords
    c.validate_password_field = false #ignoring validations for password fields
    c.merge_validates_format_of_email_field_options :message => 'does not look like an email address'
  end
  
  presence_msg = 'is required'
  
  validates_presence_of :first_name, :message => presence_msg
  
  #here we add required validations for a new record and pre-existing record
  validate do |user|
    #adds validation if it is a new record
    #adds validation if password or password_confirmation are modified
    if user.new_record? || !(!user.new_record? && user.password.blank? && user.password_confirmation.blank?)
      user.errors.add(:password, presence_msg) if user.password.blank?
      user.errors.add(:password_confirmation, presence_msg) if user.password_confirmation.blank?
      user.errors.add(:password, "should have at least 6 characters") if (user.password.present? && user.password.length < 6)
      user.errors.add(:password, "and confirmation must match") if user.password != user.password_confirmation
    end
  end
  
  mount_uploader :avatar, AvatarUploader
  
  def self.create_with_omniauth(info, country_code)
    #TODO: first/last names
    user = User.new(:first_name => info.name[0], :last_name => info.name[1], :email => info.email, :country_code => country_code)
    user.save(:validate => false) #create the user without performing validations. This is because most of the fields are not set.
    user.reset_persistence_token! #set persistence_token else sessions will not be created
    user
  end
  
  def assign_attributes(values, options = {})
    sanitize_for_mass_assignment(values, options[:as]).each do |k, v|
      send("#{k}=", v)
    end
  end
  
  def is_admin?
    self.admin
  end
  
  def name
    self.last_name.present? ? self.first_name + " #{self.last_name.capitalize}" : self.first_name
  end
  
  #********************************************
  #
  #   Business Logic
  #
  #********************************************
  
  def country
    Country.find_by_code(self.country_code)
  end
  
  def watching?(country)
    !Watching.where('user_id = ? AND country_code = ?', self.id, country.code).empty?
  end
  
  def watch(country)
    self.watchings.create(:country_code => country.code)
  end
  
  def unwatch(country)
    w = self.watchings.where('country_code = ?', country.code)
    w[0].destroy
  end
  
  def get_poll_pack_for(country_code)
    same_country = (self.country_code == country_code)
    
    # refact below line for easy reading
    coverage_condition = same_country ? [0, 1] : [0, 2]
    
    votings = self.votings.reload
    
    Poll.approved.where("(country_code = ? OR country_code = 'all') AND coverage IN (?) AND id not IN (?)", country_code, coverage_condition, votings.empty? ? 0 : votings.map(&:poll_id))
  end
  
  
  
  private
  def process_names
    #TODO: setting up unique id for permalinks here
  end
end
