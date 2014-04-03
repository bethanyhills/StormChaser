class CyclonesController < ApplicationController
  def index
    gon.cyclones = Cyclone.index_map
  end

  def show
    @cyclone = Cyclone.find(params[:id])
    gon.cyclones = @cyclone
  end

  def hist_weather_api
    respond_to do |format|
      format.json { render :json => Cyclone.historical_data(params[:id]) }
    end
  end

  def search_radius
    gon.cyclones = Cyclone.index_map
  end

  def search_api_call
    respond_to do |format|
      format.json { render :json => Cyclone.radius_search(params)}
    end
  end
end
