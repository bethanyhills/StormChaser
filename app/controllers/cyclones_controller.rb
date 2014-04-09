class CyclonesController < ApplicationController
  def index
  end

  def show
    @cyclone = Cyclone.find(params[:id])
  end

  def hist_weather_api
    respond_to do |format|
      format.json { render :json => Cyclone.historical_data(params[:id]) }
    end
  end

  def search_radius
  end

  def landing_page
    
  end
end
