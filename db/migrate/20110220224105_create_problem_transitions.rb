class CreateProblemTransitions < ActiveRecord::Migration
  def self.up
    create_table :problem_transitions do |t|
      t.integer :problem_id
      t.string :from
      t.string :to

      t.timestamps
    end

    # create init transitions for existing problems
    Problem.all.each do |problem|
      problem.problem_transitions.create(:from => nil, :to => problem.status)
    end
  end

  def self.down
    drop_table :problem_transitions
  end
end
