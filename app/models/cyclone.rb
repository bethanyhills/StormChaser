class Cyclone < ActiveRecord::Base
  belongs_to :cyclone_date
  belongs_to :path
  has_many :historical_weather

  scope :many_cyclone_map_data, -> { select('start_lat', 'start_long', 'stop_lat', 'stop_long', 'cyclones.id', 'f_scale', 'cyclones.cyclone_date_id') }
  scope :complete_cyclone_tracks, -> { joins(:path).where('paths.complete_track') }
  scope :strongest_cyclones_first, -> { order(f_scale: :desc) }
  scope :index_map, -> { complete_cyclone_tracks.strongest_cyclones_first.limit(500).many_cyclone_map_data }
  scope :deadly_cyclones, -> { where('fatalities >= 1') }
  scope :deadliest_cyclones_first, -> { order(fatalities: :desc) }
  scope :costliest_cyclones_first, -> { order(property_loss: :desc) }
  scope :scale_5_cyclones, -> { where('f_scale = 5') }
  scope :same_day_cyclones, ->(id) { where(cyclone_date_id: Cyclone.find(id).cyclone_date_id) }

  def self.historical_data(id)

    cyclone = Cyclone.find(id)

    if cyclone.historical_weather.length > 0
      weather = cyclone.historical_weather
      location_data = {}
      location_data["hourly"] = {}
      location_data["hourly"]["data"] = []
      weather.each do |data_arr|
        location_data = self.get_weather(location_data, data_arr)
      end
      return location_data
    else
      month = cyclone.cyclone_date.month.to_s
      day = cyclone.cyclone_date.day.to_s
      hour = cyclone.hour.to_s
      minute = cyclone.minute.to_s
      month = '0' + month if month.length == 1
      day = '0' + day if day.length == 1
      hour = '0' + hour if hour.length == 1
      minute = '0' + minute if minute.length == 1
      time = cyclone.cyclone_date.year.to_s + '-' + month + '-' + day + 'T' + hour + ':' + minute + ':00-0600'

      #2013-05-06T12:00:00-0400  <- Final time must be in this format for the Historical Data API call

      response = Unirest.get('https://api.forecast.io/forecast/'+ENV['FORECAST_IO_KEY'].to_s+'/'+cyclone.start_lat.to_s+','+cyclone.start_long.to_s + ',' + time,
        headers: { "Accept" => "application/json" })

      cyclone.add_weather(response.body)

      location_data = response.body
    end
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
    y2 == y1 ? m1 = 0 : m1 = (y2 - y1) / (x2 - x1)
    # Y Intercept of Tornado Path
    b1 = y1 - (m1 * x1)
    # X and Y Intercept Points between Tornado Path and Tangent Line from Circle Center
    x2 == x1 ? xi = x2 : xi = ((yc + (xc / m1) - b1) / (m1 - (1 / m1)))
    y2 == y1 ? yi = y2 : yi = ((m1 * xi) + b1)
    # Distance in degrees of the line from the Circle Center to the X,Y Intercept
    dist = Math.sqrt((xi - xc)**2 + (yi - yc)**2)
    # Distance in Miles
    dist_in_miles = dist * 25.0 / 0.3617
    # Return true if in the circle, false if out of the circle
    dist_in_miles <= radius.to_f
  end

  def add_weather(data)

    currently = data["currently"]
    weather = self.historical_weather.new
    weather.temperature = currently["temperature"] if currently["temperature"]
    weather.pressure = currently["pressure"] if currently["pressure"]
    weather.wind_speed = currently["windSpeed"] if currently["windSpeed"]
    weather.wind_bearing = currently["windBearing"] if currently["windBearing"]
    weather.hour = -9
    weather.save

    hourly = data["hourly"]["data"]
    hourly.each_with_index do |hour, index|
      weather = self.historical_weather.new
      weather.temperature = hour["temperature"] if hour["temperature"]
      weather.pressure = hour["pressure"] if hour["pressure"]
      weather.wind_speed = hour["windSpeed"] if hour["windSpeed"]
      weather.wind_bearing = hour["windBearing"] if hour["windBearing"]
      weather.hour = index
      weather.save
    end
  end

  def as_json(cyclones)
    {
      date: {
        day: self.cyclone_date.day,
        month: self.cyclone_date.month,
        year: self.cyclone_date.year,
        hour: self.hour,
        minute: self.minute,
        time_zone: self.time_zone
      },
      cyclone_strength: {
        f_scale: self.f_scale,
        width: self.width
      },
      loss: {
        injuries: self.injuries,
        fatalities: self.fatalities,
        property_loss: self.property_loss,
        crop_loss: self.crop_loss
      },
      location: {
        start_lat: self.start_lat,
        start_long: self.start_long,
        stop_lat: self.stop_lat,
        stop_long: self.stop_long,
        distance: self.distance,
        state: self.state,
        county_code_one: self.county_code_one,
        county_code_two: self.county_code_two,
        county_code_three: self.county_code_three,
        county_code_four: self.county_code_four,
        states_crossed: self.path.states_crossed
      },
      path: {
        complete_track: self.path.complete_track,
        segment_num: self.path.segment_num
      },
      touchdown_weather: self.historical_weather.first, #where('hour = 0'),
      historical_weather: self.historical_weather.offset(1).limit(24)
    }
  end

private
  def self.get_weather(weather_obj, data_arr)
    if data_arr["hour"] == -9
      current = weather_obj["currently"] = {}
      current["temperature"] = data_arr["temperature"]
      current["pressure"] = data_arr["pressure"]
      current["windSpeed"] = data_arr["wind_speed"]
      current["windBearing"] = data_arr["wind_bearing"]
    else
      hour_data = weather_obj["hourly"]["data"]
      hour_data[data_arr["hour"]] = {}
      hour_data[data_arr["hour"]]["temperature"] = data_arr["temperature"]
      hour_data[data_arr["hour"]]["pressure"] = data_arr["pressure"]
      hour_data[data_arr["hour"]]["wind_speed"] = data_arr["wind_speed"]
      hour_data[data_arr["hour"]]["wind_bearing"] = data_arr["wind_bearing"]
    end
    weather_obj
  end



end
