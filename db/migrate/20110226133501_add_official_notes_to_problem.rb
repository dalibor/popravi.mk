class AddOfficialNotesToProblem < ActiveRecord::Migration
  def self.up
    add_column :problems, :official_notes, :text
  end

  def self.down
    remove_column :problems, :official_notes
  end
end
