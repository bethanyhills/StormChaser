class API::V1::SearchesController < ApplicationController

  respond_to :html, :xml, :json

  def index
    respond_with(Cyclone.selectors(Cyclone.all, params))
  end

  def search
    # @cyclone = Cyclone.deadliest_cyclones_first
    options = { :namespace => "app_v1", :compress => true }
    dc = Dalli::Client.new('localhost:11211', options)
    if params["selectors"]
      @cyclone = dc.fetch(params["search_name"]+1.to_s+params["selectors"]) {
        cyclone = Cyclone.searches(params)
        cyclone = Cyclone.selectors(cyclone, params) if params["selectors"]
        cyclone = cyclone.to_json
      }
    else
      @cyclone = dc.fetch(params["search_name"]+1.to_s) {
        cyclone = Cyclone.searches(params)
        cyclone = cyclone.to_json
      }
    end
    # @cyclone = Cyclone.searches(params)
    respond_with(@cyclone)
  end

end
