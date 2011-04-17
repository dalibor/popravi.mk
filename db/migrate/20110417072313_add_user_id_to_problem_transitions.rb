class AddUserIdToProblemTransitions < ActiveRecord::Migration
  def self.up
    add_column :problem_transitions, :user_id, :integer
  end

  def self.down
    remove_column :problem_transitions, :user_id
  end
end
