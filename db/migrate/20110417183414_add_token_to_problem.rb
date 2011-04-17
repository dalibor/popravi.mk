class AddTokenToProblem < ActiveRecord::Migration
  def self.up
    add_column :problems, :token, :string
  end

  def self.down
    remove_column :problems, :token
  end
end
