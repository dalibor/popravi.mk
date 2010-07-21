class AddWeightToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :weight, :integer, :default => '5'
  end

  def self.down
    remove_column :problems, :weight
  end
end
