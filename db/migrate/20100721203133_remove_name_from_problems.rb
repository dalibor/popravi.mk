class RemoveNameFromProblems < ActiveRecord::Migration
  def self.up
    remove_column :problems, :name
  end

  def self.down
    add_column :problems, :name, :string
  end
end
