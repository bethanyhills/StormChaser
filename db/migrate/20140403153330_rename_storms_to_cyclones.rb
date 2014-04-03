class RenameStormsToCyclones < ActiveRecord::Migration
  def self.up
    rename_table :storms, :cyclones
  end
  def self.down
    rename_table :cyclones, :storms
  end
end
