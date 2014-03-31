class StormsController < ApplicationController
  def index
  	gon.storms = Storm.all
  end

  def show
    gon.storms = Storm.find(params[:id])
  end
end
