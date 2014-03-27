class CreateTornadoDates < ActiveRecord::Migration
  def change
    create_table :tornado_dates do |t|
      t.integer :day
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
