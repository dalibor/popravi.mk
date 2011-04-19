class AddApiKeyIdToProblems < ActiveRecord::Migration
  def self.up
    add_column :problems, :api_key_id, :integer
  end

  def self.down
    remove_column :problems, :api_key_id
  end
end
