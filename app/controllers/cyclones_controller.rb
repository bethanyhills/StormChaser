class CyclonesController < ApplicationController
  def index
    # gon.cyclones = Cyclone.index_map
    # gon.cyclones = {'cyclones' => Cyclone.index_map, 'date' => CycloneDate.all}
  end

  def show
    @cyclone = Cyclone.find(params[:id])
    # gon.cyclones = @cyclone

    # respond_to do |format|
    #   format.html {}
    #   format.json { render :json => @cyclone, status: 200 }
    # end
  end

  def hist_weather_api
    respond_to do |format|
      format.json { render :json => Cyclone.historical_data(params[:id]) }
    end
  end

  def search_radius
    # gon.cyclones = Cyclone.index_map
  end

  def search_api_call
    respond_to do |format|
      format.json { render :json => Cyclone.radius_search(params)}
    end
  end

  def landing_page
    
  end
end
