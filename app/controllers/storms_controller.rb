class StormsController < ApplicationController
  def index
    gon.storms = Storm.index_map()
  end

  def show
    @storm = Storm.find(params[:id])
    @date = @storm.tornado_date
    gon.storms = @storm

    respond_to do |format|
      format.html {}
      format.json { render :json => @storm, status: 200 }
    end
  end

  def hist_weather_api
    #Add to the database
    respond_to do |format|
      format.json { render :json => Storm.historical_data(params[:id]) }
    end
  end

  def search_radius
    gon.storms = Storm.index_map()
  end

  def search_api_call

    city = params["city"].gsub(" ", "+")
    state = params["state"]
    radius = params["radius"]
    response = Unirest.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{city},+#{state}&sensor=false&key=#{ENV["GOOGLE_GEO_KEY"]}")

    lat = response.body["results"][0]["geometry"]["location"]["lat"]
    lng = response.body["results"][0]["geometry"]["location"]["lng"]

    storms = Storm.radius_search(lat.to_f, lng.to_f, radius.to_f)

    respond_to do |format|
      format.json { render :json => storms}
    end
  end
end
