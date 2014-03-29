class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.integer :states_crossed
      t.boolean :complete_track
      t.integer :segment_num

      t.timestamps
    end
  end
end
