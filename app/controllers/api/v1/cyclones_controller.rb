class API::V1::CyclonesController < ApplicationController

  respond_to :html, :xml, :json

  def index
    respond_with(Cyclone.limit(500))
  end

  def show
    respond_with(@cyclone = Cyclone.find(params[:id]))
  end

end
