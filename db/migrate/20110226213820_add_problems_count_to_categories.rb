class AddProblemsCountToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :problems_count, :integer
  end

  def self.down
    remove_column :categories, :problems_count
  end
end
