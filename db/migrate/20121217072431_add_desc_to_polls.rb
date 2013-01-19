class AddDescToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :description, :text
  end
end
