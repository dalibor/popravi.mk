class AddProblemsCountToMunicipalities < ActiveRecord::Migration
  def self.up
    add_column :municipalities, :problems_count, :integer, :default => 0
  end

  def self.down
    remove_column :municipalities, :problems_count
  end
end
