class ChangeStatusInProblems < ActiveRecord::Migration
  def self.up
    change_column :problems, :status, :string
    Problem.reset_column_information
    Problem.update_all('status = "reported"')
  end

  def self.down
    change_column :problems, :status, :integer, :default => 0
    Problem.reset_column_information
    Problem.update_all('status = 0')
  end
end
