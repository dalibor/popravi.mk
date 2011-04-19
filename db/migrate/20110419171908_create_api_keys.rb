class CreateApiKeys < ActiveRecord::Migration
  def self.up
    create_table :api_keys do |t|
      t.string :name
      t.string :key
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :api_keys
  end
end
