class StormsController < ApplicationController
  def index
    gon.storms = Storm.index_map()
  end

  def show
    @storm = Storm.find(params[:id])
    @date = @storm.tornado_date
    gon.storms = @storm
  end

  def hist_weather_api
    respond_to do |format|
      format.json { render :json => Storm.historical_data(params[:id]) }
    end
  end
end
