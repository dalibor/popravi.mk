class ChangeStatusInProblems < ActiveRecord::Migration
  def self.up
    change_column :problems, :status, :string
  end

  def self.down
    change_column :problems, :status, :integer, :default => 0
  end
end
