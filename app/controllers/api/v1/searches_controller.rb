class API::V1::SearchesController < ApplicationController

  respond_to :html, :xml, :json

  def index
    respond_with(Cyclone.selectors(Cyclone.all, params))
  end

  def search
    # @cyclone = Cyclone.deadliest_cyclones_first
    @cyclone = Cyclone.searches(params)
    @cyclone = Cyclone.selectors(cyclone, params) if params["selectors"]
    respond_with(@cyclone.to_json)
  end

end
