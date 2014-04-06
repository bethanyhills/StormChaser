class API::V1::SearchesController < ApplicationController

  respond_to :html, :xml, :json

  def index
    respond_with(Cyclone.limit(500))
  end

  def deadliest
    @cyclone = Cyclone.deadliest_cyclones_first
    if params["selectors"]
      selectors = params["selectors"].split(',')
      selectors.each do |selector|
        x = selector.split(':')


        if x[1][-1] == '+'
          @cyclone = @cyclone.where(x[0] + ' >= ' + x[1][0...-1])
        elsif x[1][-1] == '-'
          @cyclone = @cyclone.where(x[0] + ' <= ' + x[1][0...-1])
        else
          @cyclone = @cyclone.where(x[0] + ' = ' + x[1])
        end
      end
    end
    # @cyclone.where('f_scale = 4')
    respond_with(@cyclone)
  end

end
