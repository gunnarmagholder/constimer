require 'uuidtools'

class AddUuidToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :uuid, :string
    UUIDTools::UUID.mac_address="12:34:56:78:90:12"
    Project.all.each do |p|
      p.uuid = UUIDTools::UUID.timestamp_create.to_s
      p.save
    end
  end

  def self.down
    remove_column :users, :uuid
  end
end
