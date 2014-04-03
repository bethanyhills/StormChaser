class Storm < ActiveRecord::Base
  belongs_to :tornado_date
  belongs_to :path

  #scope :published, -> { where(published: true) }
  scope :many_storm_map_data, -> { select("start_lat", "start_long", "stop_lat", "stop_long", "storms.id", "f_scale") }
  scope :strongest_first, -> { order(f_scale: :desc) }
  scope :complete_track, -> { joins(:path).where("paths.complete_track") }
  scope :index_map, -> { complete_track.strongest_first.limit(500).many_storm_map_data }

  def self.historical_data(id)
    storm = Storm.find(id)
    month = storm.tornado_date.month.to_s
    day = storm.tornado_date.day.to_s
    hour = storm.hour.to_s
    minute = storm.minute.to_s
    month = '0' + month if month.length == 1
    day = '0' + day if day.length == 1
    hour = '0' + hour if hour.length == 1
    minute = '0' + minute if minute.length == 1
    time = storm.tornado_date.year.to_s + '-' + month + '-' + day + 'T' + hour + ':' + minute + ':00-0600'

    #2013-05-06T12:00:00-0400  <- Final time must be in this format for the Historical Data API call

    response = Unirest.get('https://api.forecast.io/forecast/'+ENV['FORECAST_IO_KEY'].to_s+'/'+storm.start_lat.to_s+','+storm.start_long.to_s + ',' + time,
      headers: { "Accept" => "application/json" })

    location_data = response.body
  end

  def self.radius_search(xc, yc, radius)
    all = Storm.all
    all.select{|storm| storm._radius_search(xc, yc, radius)}
  end

  def _radius_search(xc, yc, radius)
    #Start Point
    x1 = self.start_lat
    y1 = self.start_long
    #Stop Point
    self.stop_lat == 0 ? x2 = x1 : x2 = self.stop_lat
    self.stop_long == 0 ? y2 = y1 : y2 = self.stop_long
    #Slope of Tornado Path
    x2 == x1 ? m1 = 0 : m1 = (y2-y1)/(x2-x1)
    #Y Intercept of Tornado Path
    b1 = y1 - m1*x1
    #X and Y Intercept Points between Tornado Path and Tangent Line from Circle Center
    x2 = x1 ? xi = x2 : xi = (yc + (xc/m1) - b1)/(m1 - (1/m1))
    y2 = y1 ? yi = y2 : yi = m1*xi + b1
    #Distance in degrees of the line from the Circle Center to the X,Y Intercept
    dist = Math.sqrt((xi-xc)**2+(yi-yc)**2)
    #Distance in Miles
    dist_in_miles = dist*25.0/0.3617
    #Return true if in the circle, false if out of the circle
    dist_in_miles <= radius
  end
end
