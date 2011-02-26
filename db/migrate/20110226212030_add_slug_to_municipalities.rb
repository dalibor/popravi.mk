class AddSlugToMunicipalities < ActiveRecord::Migration
  def self.up
    add_column :municipalities, :slug, :string

    Municipality.all.each do |municipality|
      municipality.save
    end
  end

  def self.down
    remove_column :municipalities, :slug
  end
end
