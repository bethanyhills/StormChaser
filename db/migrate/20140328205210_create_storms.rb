class CreateStorms < ActiveRecord::Migration
  def change
    create_table :storms do |t|
      t.references :tornado_date, index: true
      t.references :path, index: true
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
      t.integer :county_code_one
      t.integer :county_code_two
      t.integer :county_code_three
      t.integer :county_code_four

      t.timestamps
    end
  end
end


class CreateTornados < ActiveRecord::Migration
  def change
    create_table :tornados do |t|
      t.references :tornado_dates, index: true


      t.timestamps
    end
  end
end
