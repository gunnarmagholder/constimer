class AddManagerToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :managed_by, :integer
  end

  def self.down
    remove_column :users, :managed_by
  end
end
