class AddMinutesToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :minutes, :integer
  end

  def self.down
    remove_column :entries, :minutes
  end
end
