require 'spec_helper'
require 'rake'
require 'pry'
require 'apis/api_helper'
require 'Unirest'

# require_relative ''

describe 'CycloneAPI' do #, :type => :controller do
    # GET /tasks/:id

  # it 'Grabs individual storm data' do
  #   response = Unirest.get("http://localhost:3000/storms/1", headers: { "Accept" => "application/json" })
  #   response.code.should == 200

  #   puts response.body
  #   cyclone = response.body
  #   # cyclone = JSON.parse(response.body)
  #   cyclone["id"].should == 1
  #   cyclone["tornado_date_id"].should == 1
  #   cyclone["path_id"].should == 1
  #   cyclone["f_scale"].should == 5
  #   cyclone["hour"].should == 16
  #   cyclone["minute"].should == 10
  #   cyclone["time_zone"].should == 3
  #   cyclone["state"].should == 'TX'
  #   cyclone["injuries"].should == 597
  #   cyclone["fatalities"].should == 114
  #   cyclone["property_loss"].should == 7.0
  #   cyclone["crop_loss"].should == 0.0
  #   cyclone["start_lat"].should == 31.55
  #   cyclone["start_long"].should == -97.15
  #   cyclone["stop_lat"].should == 31.75
  #   cyclone["stop_long"].should == -96.88
  #   cyclone["distance"].should == 20.9
  #   cyclone["width"].should == 583.0
  #   cyclone["county_code_one"].should == 309
  #   cyclone["county_code_two"].should == 0
  #   cyclone["county_code_three"].should == 0
  #   cyclone["county_code_four"].should == 0
  # end

end
