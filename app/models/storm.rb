class Storm < ActiveRecord::Base
  belongs_to :tornado_date
  belongs_to :path

  def self.many_storm_map_data()
    self.select("start_lat", "start_long", "stop_lat", "stop_long", "storms.id", "f_scale")
  end

  def self.index_map()
    Storm.joins(:path).where("paths.complete_track").order(f_scale: :desc).limit(500).many_storm_map_data
  end

end
