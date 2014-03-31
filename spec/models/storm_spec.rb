require 'spec_helper'
before(:each) do
    @storm = Storm.all.limit(10)
end

describe Storm do
  describe "#many_storm_map_data" do
  	it "returns an array of objects holding tornado data" do
     @storm.many_storm_map_data()

     expect(@storm.first.start_lat).to exist
     expect(@storm.first.width).to_not exist
     expect(@storm.length).to be(10)
    end
  end
end
