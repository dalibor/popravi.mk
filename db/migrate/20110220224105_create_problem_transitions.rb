class CreateProblemTransitions < ActiveRecord::Migration
  def self.up
    create_table :problem_transitions do |t|
      t.integer :problem_id
      t.string :from
      t.string :to

      t.timestamps
    end
  end

  def self.down
    drop_table :problem_transitions
  end
end
