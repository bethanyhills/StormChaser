class API::V1::CyclonesController < ApplicationController
  require 'dalli'

  respond_to :html, :xml, :json

  def index
    options = { :namespace => "app_v1", :compress => true }
    dc = Dalli::Client.new('localhost:11211', options)
    cyclones = dc.fetch('index_map') { Cyclones.index_map.to_json }
    respond_with(cyclones)
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
