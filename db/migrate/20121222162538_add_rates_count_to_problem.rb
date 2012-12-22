class AddRatesCountToProblem < ActiveRecord::Migration
  def up
    add_column :problems, :rates_count, :integer, :default => 0

    Problem.reset_column_information
    Problem.all.each do |problem|
      Problem.update_counters(problem.id, :rates_count => problem.rates.length)
    end
  end

  def down
    remove_column :problems, :rates_count
  end
end
