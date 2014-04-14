class CyclonesController < ApplicationController
  def index
  end

  def show
    @cyclone = Cyclone.find(params[:id])
  end

  def search_radius
  end

  def landing_page
  end

  def about
  end
end
