class StormsController < ApplicationController
  def index
  	gon.storms = Storm.all
  end
  
  def show
  end
end
