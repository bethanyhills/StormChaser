class StormsController < ApplicationController
  def index
    gon.storms = Storm.index_map()
  end

  def show
    @storm = Storm.find(params[:id])
    @date = TornadoDate.find(@storm.tornado_date_id)
    gon.storms = @storm
  end
end
