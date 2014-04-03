class StormsController < ApplicationController
  def index
    gon.storms = Storm.index_map
  end

  def show
    @storm = Storm.find(params[:id])
    gon.storms = @storm
  end

  def hist_weather_api
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
