class MakeCommentsPolymorphic < ActiveRecord::Migration
  def self.up
    rename_column :comments, :problem_id, :commentable_id
    add_column :comments, :commentable_type, :string
    add_index :comments, :user_id
    add_index :comments, [:commentable_id, :commentable_type]
  end

  def self.down
    remove_index :comments, :user_id
    remove_index :comments, [:commentable_id, :commentable_type]
    rename_column :comments, :commentable_id, :problem_id
    remove_column :comments, :commentable_type
  end
end
