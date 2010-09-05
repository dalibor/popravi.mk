class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :user_id
      t.string :slug
      t.string :title
      t.text :content
      t.datetime :published_at
      t.boolean :comments_closed

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
