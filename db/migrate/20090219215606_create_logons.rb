class CreateLogons < ActiveRecord::Migration
  def self.up
    create_table :logons do |t|
      t.integer :user
      t.timestamps
    end
  end

  def self.down
    drop_table :logons
  end
end
