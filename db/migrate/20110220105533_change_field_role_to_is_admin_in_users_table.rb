class ChangeFieldRoleToIsAdminInUsersTable < ActiveRecord::Migration
  def self.up
    rename_column :users, :role, :is_admin
    change_column :users, :is_admin, :boolean, :default => 0
  end

  def self.down
    rename_column :users, :is_admin, :role
    change_column :users, :role, :string
  end
end
