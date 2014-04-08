class CreateAvgCycloneData < ActiveRecord::Migration
  def change
    create_table :avg_cyclone_data do |t|
      t.string :year
      t.float :fatalities
      t.float :property_loss
      t.float :crop_loss
      t.float :injuries
      t.float :distance
      t.float :f_scale

      t.timestamps
    end
  end
end
