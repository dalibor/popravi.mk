class AddSolvedAtToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :solved_at, :timestamp

    Problem.reset_column_information
    Problem.with_status('solved').each do |problem|
      puts "Seting solved_at field for problem: #{problem.id} to value: #{problem.created_at}"
      problem.solved_at = problem.updated_at
      problem.save(:validate => false)
    end
  end

  def self.down
    remove_column :problems, :solved_at
  end
end
