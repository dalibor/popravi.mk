class AddSolvedAtToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :solved_at, :timestamp
  end

  def self.down
    remove_column :problems, :solved_at
  end
end
