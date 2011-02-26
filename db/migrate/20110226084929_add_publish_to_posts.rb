class AddPublishToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :published, :boolean, :default => true
  end

  def self.down
    remove_column :posts, :published
  end
end
