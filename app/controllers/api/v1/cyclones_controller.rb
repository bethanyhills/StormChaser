class API::V1::CyclonesController < ApplicationController

  respond_to :html, :xml, :json

  def index
    respond_with(Cyclone.limit(500))
  end

  def show
    if params[:id].to_i == 0
      params[:selectors] = params[:id]
      @cyclone = Cyclone.selectors(Cyclone.all, params)
    else
      @cyclone = Cyclone.find(params[:id])
    end
    respond_with(@cyclone)
  end

end
