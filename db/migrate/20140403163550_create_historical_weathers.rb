class CreateHistoricalWeathers < ActiveRecord::Migration
  def change
    create_table :historical_weathers do |t|
      t.float :wind_speed
      t.float :wind_bearing
      t.float :temperature
      t.float :pressure
      t.integer :hour
      t.references :cyclone, index: true

      t.timestamps
    end
  end
end
