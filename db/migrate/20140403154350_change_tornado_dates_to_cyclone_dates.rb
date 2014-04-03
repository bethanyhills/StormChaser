class ChangeTornadoDatesToCycloneDates < ActiveRecord::Migration
  def self.up
    rename_column :cyclones, :tornado_date_id, :cyclone_date_id
  end

  def self.down
    rename_column :cyclones, :cyclone_date_id, :tornado_date_id
  end
end
