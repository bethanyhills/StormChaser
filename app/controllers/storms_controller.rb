class StormsController < ApplicationController
  def index
  	gon.storms = Storm.joins(:paths).where(paths: {complete_track: true})
  end

  def show
    gon.storms = Storm.find(params[:id])
  end
end
