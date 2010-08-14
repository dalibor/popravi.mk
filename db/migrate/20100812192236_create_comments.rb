class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :user_id
      t.integer :problem_id
      t.string :name
      t.string :email
      t.text :content
      t.boolean :approved, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
