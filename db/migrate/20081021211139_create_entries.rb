class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.references :user
      t.date :edate
      t.time :starttime
      t.time :endtime
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
