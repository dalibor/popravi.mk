class CreateProblems < ActiveRecord::Migration
  def self.up
    create_table :problems do |t|
      t.references :user
      t.references :category
      t.references :municipality
      t.text :description
      t.integer :status, :default => 0
      t.string :longitude
      t.string :latitude
      t.string :name
      t.string :email

      t.timestamps
    end
    add_index :problems, :email
  end

  def self.down
    drop_table :problems
  end
end
