class Storm < ActiveRecord::Base
  belongs_to :tornado_date
  belongs_to :path

  def self.many_storm_map_data()
    self.select("start_lat", "start_long", "stop_lat", "stop_long", "storms.id", "f_scale")
  end

  def self.index_map()
    Storm.joins(:path).where("paths.complete_track").order(f_scale: :desc).limit(500).many_storm_map_data
  end

  def self.historical_data(id)
    require 'unirest'
    storm = Storm.find(id)
    month = storm.tornado_date.month.to_s
    month = '0' + month if month.length == 1
    day = storm.tornado_date.day.to_s
    day = '0' + day if day.length == 1
    hour = storm.hour.to_s
    hour = '0' + hour if hour.length == 1
    minute = storm.minute.to_s
    minute = '0' + minute if minute.length == 1
    time = storm.tornado_date.year.to_s + '-' + month + '-' + day + 'T' + hour + ':' + minute + ':00-0600'

    #2013-05-06T12:00:00-0400  <- Final time must be in this format for the Historical Data API call

    response = Unirest.get('https://api.forecast.io/forecast/'+ENV['FORECAST_IO_KEY'].to_s+'/'+storm.start_lat.to_s+','+storm.start_long.to_s + ',' + time,
      headers: { "Accept" => "application/json" })

    location_data = response.body
  end

end
