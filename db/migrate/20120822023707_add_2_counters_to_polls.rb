class Add2CountersToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :positive_votings_count, :integer
    add_column :polls, :negative_votings_count, :integer
  end
end
