class AddProblemsCountToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :problems_count, :integer

    Category.reset_column_information
    Category.find(:all).each do |category|
      Category.update_counters category.id,
        :problems_count => category.problems.length
    end
  end

  def self.down
    remove_column :categories, :problems_count
  end
end
