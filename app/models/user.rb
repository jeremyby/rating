class User < ActiveRecord::Base
  include ActiveModel::MassAssignmentSecurity

  attr_accessor :password_confirmation

  attr_accessible :first_name, :last_name, :email, :country_code, :password, :password_confirmation, :avatar

  before_save :process_names

  belongs_to  :country,               :foreign_key => 'country_code',     :primary_key => 'code'
  has_many :authorizations,           :dependent => :destroy

  has_many :followings, :dependent => :destroy
  has_many :watching_countries, :through => :followings, :source => :followable, :source_type => 'Country'
  has_many :following_polls, :through => :followings, :source => :followable, :source_type => 'Poll'

  has_many :polls
  has_many :votings, :dependent => :destroy

  acts_as_authentic do |c|
    c.ignore_blank_passwords = true #ignoring passwords
    c.validate_password_field = false #ignoring validations for password fields
    c.merge_validates_format_of_email_field_options :message => 'does not look like an email address'
  end

  acts_as_voter

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

  def self.build_from_info(info, country_code)
    User.new(:first_name => info.name[0], :last_name => info.name[1], :email => info.email, :country_code => country_code)
  end

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

  def to_s
    self.name
  end

  #********************************************
  #
  #   Business Logic
  #
  #********************************************

  def country
    Country.find_by_code(self.country_code)
  end

  def lives_in?(country)
    self.country_code == (country.class == Country ? country.code : country)
  end

  def following?(followable)
    !self.followings.where(:followable_id => followable.id, :followable_type => followable.class).blank?
  end

  def follow(followable)
    self.followings.create!(:followable => followable)
  end

  def unfollow(followable)
    f = self.followings.where(:followable_id => followable.id, :followable_type => followable.class)
    f.first.destroy
  end

  def can_answer?(poll)
    case poll.coverage
    when 0 then return true
    when 1 then return self.lives_in?(poll.country_code)
    when 2 then return !self.lives_in?(poll.country_code)
    end
  end

  def get_poll_pack_for(country_code)
    coverage_condition = self.lives_in?(country_code) ? [0, 1] : [0, 2]

    votings = self.votings.reload

    Poll.approved.where("(country_code = ? OR country_code = 'all') AND coverage IN (?) AND id not IN (?)", country_code, coverage_condition, votings.empty? ? 0 : votings.map(&:poll_id))
  end



  private
  def process_names
    #TODO: setting up unique id for permalinks here
  end
end
