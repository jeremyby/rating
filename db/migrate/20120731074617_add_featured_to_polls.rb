class AddFeaturedToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :featured, :boolean, :default => false
  end
end
