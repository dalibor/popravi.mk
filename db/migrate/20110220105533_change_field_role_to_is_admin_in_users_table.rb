class ChangeFieldRoleToIsAdminInUsersTable < ActiveRecord::Migration
  def self.up
    admin_user_ids = User.where('role = "admin"').map{|u| u.id}
    rename_column :users, :role, :is_admin
    change_column :users, :is_admin, :boolean, :default => 0
    User.reset_column_information
    admin_user_ids.each do |id|
      user = User.find(id)
      user.is_admin = true
      user.save!
    end
    User.find(:all, :conditions => 'is_admin IS NULL').each do |user|
      user.is_admin = false
      user.save(false)
    end
  end

  def self.down
    admin_user_ids = User.where('is_admin = TRUE').map{|u| u.id}
    rename_column :users, :is_admin, :role
    change_column :users, :role, :string
    User.reset_column_information
    admin_user_ids.each do |id|
      user = User.find(id)
      user.role = 'admin'
      user.save!
    end
    User.find(:all, :conditions => 'role = NULL').each do |user|
      user.role = "0"
      user.save(false)
    end
  end
end
