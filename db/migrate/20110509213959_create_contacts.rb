class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :municipality_id
      t.text :about
      t.string :address
      t.string :phone
      t.string :web
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
