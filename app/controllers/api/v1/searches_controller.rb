class API::V1::SearchesController < ApplicationController

  respond_to :html, :xml, :json

  def index
    cyclone = Cyclone.selectors(Cyclone.all, params)
    if cyclone.is_a?(Hash)
      puts "Error below"
      puts cyclone[:error]
      render :json => cyclone[:error], :status => cyclone[:status]
    else
      respond_with(cyclone)
    end
    respond_with(cyclone)
  end

  def search
    cyclone = Cyclone.selectors(params)
    if cyclone.is_a?(Hash)
      render :json => cyclone[:error], :status => cyclone[:status]
    else
      respond_with(cyclone)
    end
  end

end
