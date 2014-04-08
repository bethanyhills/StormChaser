class StormsController < ApplicationController
  def index
    gon.storms = Storm.index_map
  end

  def show
    @storm = Storm.find(params[:id])
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
    gon.storms = Storm.index_map
  end

  def search_api_call
    respond_to do |format|
      format.json { render :json => Storm.radius_search(params)}
    end
  end
end
