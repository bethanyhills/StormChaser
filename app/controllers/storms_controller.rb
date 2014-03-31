class StormsController < ApplicationController
  def index
    gon.storms = Storm.index_map()
  end

  def show
    @storm = Storm.find(params[:id])
    @date = TornadoDate.find(@storm.tornado_date_id)
    gon.storms = @storm
  end

  def hist_weather_api
    require 'unirest'
    storm = Storm.find(params[:id])
    month = storm.tornado_date.month.to_s
    month = '0' + month if month.length == 1
    day = storm.tornado_date.day.to_s
    day = '0' + day if day.length == 1
    time = storm.tornado_date.year.to_s + '-' + month + '-' + day + 'T' + storm.hour.to_s + ':' + storm.minute.to_s + ':00-0600'
    puts time

    #2013-05-06T12:00:00-0400

    response = Unirest.get('https://api.forecast.io/forecast/'+ENV['FORECAST_IO_KEY'].to_s+'/'+storm.start_lat.to_s+','+storm.start_long.to_s + ',' + time,
      headers: { "Accept" => "application/json" })

    location_data = response.body

    respond_to do |format|
      format.html # show.html.erb
      # format.xml  { render :xml => l }
      format.json { render :json => location_data }
    end
  end
end
