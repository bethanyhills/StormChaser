class Cyclone < ActiveRecord::Base
  belongs_to :cyclone_date
  belongs_to :path

  scope :many_cyclone_map_data, -> { select('start_lat', 'start_long', 'stop_lat', 'stop_long', 'cyclones.id', 'f_scale') }
  scope :complete_cyclone_tracks, -> { joins(:path).where('paths.complete_track') }
  scope :strongest_cyclones_first, -> { order(f_scale: :desc) }
  scope :index_map, -> { complete_cyclone_tracks.strongest_cyclones_first.limit(500).many_cyclone_map_data }

  def self.historical_data(id)
    cyclone = Cyclone.find(id)
    month = cyclone.cyclone_date.month.to_s
    day = cyclone.cyclone_date.day.to_s
    hour = cyclone.hour.to_s
    minute = cyclone.minute.to_s
    month = '0' + month if month.length == 1
    day = '0' + day if day.length == 1
    hour = '0' + hour if hour.length == 1
    minute = '0' + minute if minute.length == 1
    time = cyclone.cyclone_date.year.to_s + '-' + month + '-' + day + 'T' + hour + ':' + minute + ':00-0600'

    # 2013-05-06T12:00:00-0400  <- Final time must be in this format for the Historical Data API call

    response = Unirest.get('https://api.forecast.io/forecast/' + ENV['FORECAST_IO_KEY'].to_s + '/' +
      cyclone.start_lat.to_s + ',' + cyclone.start_long.to_s + ',' + time,
      headers: { 'Accept' => 'application/json' })

    response.body
  end

  def self.radius_search(params)

    city = params['city'].gsub(' ', '+')
    state = params['state']
    radius = params['radius']
    response = Unirest.get('https://maps.googleapis.com/maps/api/geocode/json?address=' + city + ',+' + state + '&sensor=false&key=' + ENV["GOOGLE_GEO_KEY"])

    lat = response.body['results'][0]['geometry']['location']['lat']
    lng = response.body['results'][0]['geometry']['location']['lng']

    self.complete_cyclone_tracks.strongest_cyclones_first.select{|cyclone| cyclone.radius_search_results(lat, lng, radius) }
  end

  def radius_search_results(xc, yc, radius)
    # Start Point
    x1 = self.start_lat
    y1 = self.start_long
    # Stop Point
    self.stop_lat == 0 ? x2 = x1 : x2 = self.stop_lat
    self.stop_long == 0 ? y2 = y1 : y2 = self.stop_long
    # Slope of Tornado Path
    x2 == x1 ? m1 = 0 : m1 = (y2 - y1) / (x2 - x1)
    # Y Intercept of Tornado Path
    b1 = y1 - m1 * x1
    # X and Y Intercept Points between Tornado Path and Tangent Line from Circle Center
    x2 == x1 ? xi = x2 : xi = (yc + (xc / m1) - b1) / (m1 - (1 / m1))
    y2 == y1 ? yi = y2 : yi = m1 * xi + b1
    # Distance in degrees of the line from the Circle Center to the X,Y Intercept
    dist = Math.sqrt((xi - xc)**2 + (yi - yc)**2)
    # Distance in Miles
    dist_in_miles = dist * 25.0 / 0.3617
    # Return true if in the circle, false if out of the circle
    dist_in_miles <= radius.to_f
  end
end
