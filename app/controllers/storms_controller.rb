class StormsController < ApplicationController
  def index
  	gon.storms = Storm.all
  end

  def show
    gon.storms = Storm.find_by(id: params[:id])
  end
end
