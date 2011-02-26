class AddProblemsCountToMunicipalities < ActiveRecord::Migration
  def self.up
    add_column :municipalities, :problems_count, :integer, :default => 0

    Municipality.reset_column_information
    Municipality.find(:all).each do |municipality|
      Municipality.update_counters municipality.id,
        :problems_count => municipality.problems.length
    end
  end

  def self.down
    remove_column :municipalities, :problems_count
  end
end
