class AddSlugToMunicipalities < ActiveRecord::Migration
  def self.up
    add_column :municipalities, :slug, :string
  end

  def self.down
    remove_column :municipalities, :slug
  end
end
