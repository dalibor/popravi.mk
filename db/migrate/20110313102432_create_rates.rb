class CreateRates < ActiveRecord::Migration
  def self.up
    create_table :rates do |t|
      t.integer :problem_id
      t.integer :user_id
      t.integer :weight

      t.timestamps
    end
  end

  def self.down
    drop_table :rates
  end
end
