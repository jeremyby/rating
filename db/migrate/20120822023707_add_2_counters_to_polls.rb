class Add2CountersToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :yes_votings_count, :integer
    add_column :polls, :no_votings_count, :integer
  end
end
