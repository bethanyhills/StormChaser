class API::V1::CyclonesController < ApplicationController
  require 'dalli'

  respond_to :html, :xml, :json

  def index
    options = { :namespace => "app_v1", :compress => true }
    dc = Dalli::Client.new('localhost:11211', options)
    cyclones = dc.fetch('index_map') { Cyclone.index_map.to_json }
    respond_with(cyclones)
  end

  def show
    if params[:id].to_i == 0
      params[:selectors] = params[:id]
      cyclone = Cyclone.selectors(params)
    else
      cyclone = Cyclone.find(params[:id])
    end

    if cyclone.is_a?(Hash)
      puts "Error below"
      puts cyclone[:error]
      render :json => cyclone[:error], :status => cyclone[:status]
    else
      respond_with(cyclone)
    end
  end

  def hist_weather_api
    respond_to do |format|
      format.json { render :json => Cyclone.historical_data(params[:id]) }
    end
  end

end
