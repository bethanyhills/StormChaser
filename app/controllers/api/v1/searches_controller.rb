class API::V1::SearchesController < ApplicationController

  respond_to :html, :xml, :json

  def index
    respond_with(Cyclone.selectors(Cyclone.all, params))
  end

  def search
    respond_with(Cyclone.search(params))
  end

end
