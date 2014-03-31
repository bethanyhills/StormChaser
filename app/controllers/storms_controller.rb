class StormsController < ApplicationController
  def index
  	gon.storms = Storm.where(path_id: [1,2,5])
  end

  def show
    gon.storms = Storm.find(params[:id])
  end
end
