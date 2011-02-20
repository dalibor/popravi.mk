class AddMunicipalityIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :municipality_id, :integer
  end

  def self.down
    remove_column :users, :municipality_id
  end
end
