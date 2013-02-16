class Following < ActiveRecord::Base
  belongs_to :followable, :polymorphic => true, :counter_cache => true
  belongs_to :user

  attr_accessible :followable

  validates_uniqueness_of :user_id, :scope => [:followable_id, :followable_type]
end
