class AddLastLogonToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_logon, :datetime
  end

  def self.down
    remove_column :users, :last_logon
  end
end
