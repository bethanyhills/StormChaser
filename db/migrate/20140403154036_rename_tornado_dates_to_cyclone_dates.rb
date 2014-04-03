class RenameTornadoDatesToCycloneDates < ActiveRecord::Migration
  def self.up
    rename_table :tornado_dates, :cyclone_dates
  end
  def self.down
    rename_table :cyclone_dates, :tornado_dates
  end
end

