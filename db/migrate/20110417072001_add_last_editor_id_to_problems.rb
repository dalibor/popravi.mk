class AddLastEditorIdToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :last_editor_id, :integer
  end

  def self.down
    remove_column :problems, :last_editor_id
  end
end
