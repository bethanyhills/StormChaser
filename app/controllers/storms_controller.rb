class StormsController < ApplicationController
  def index
  	gon.storms = Storm.where(path_id: [1,2,5]).many_storm_map_data  #Works for only Cat 5s
  end

  def show
    @storm = Storm.find(params[:id])
    @date = TornadoDate.find(@storm.tornado_date_id)
    gon.storms = @storm
  end
end
