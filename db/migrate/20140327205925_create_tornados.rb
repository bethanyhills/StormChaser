class CreateTornados < ActiveRecord::Migration
  def change
    create_table :tornados do |t|
      t.references :tornado_dates, index: true
      t.integer :f_scale
      t.integer :hour
      t.integer :minute
      t.integer :time_zone
      t.string :state
      t.integer :injuries
      t.integer :fatalities
      t.float :property_loss
      t.float :crop_loss
      t.float :start_lat
      t.float :start_long
      t.float :stop_lat
      t.float :stop_long
      t.float :distance
      t.float :width
      t.integer :states_crossed
      t.boolean :complete_track
      t.integer :segment_num
      t.integer :county_code_one
      t.integer :county_code_two
      t.integer :county_code_three
      t.integer :county_code_four

      t.timestamps
    end
  end
end
