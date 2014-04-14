require 'spec_helper'
require 'rake'
require 'pry'

StormChaser::Application.load_tasks
Rake::Task.define_task(:environment)
Rake::Task['db:drop'].invoke
Rake::Task['db:create'].invoke
Rake::Task['db:migrate'].invoke
Rake::Task['import:year_2011'].invoke


describe Cyclone do

  describe "#many_cyclone_map_data" do
    it "returns an array of objects holding tornado data" do
    	cyclone = Cyclone.many_cyclone_map_data
      expect(cyclone.first.start_lat).to_not be_nil
      expect(cyclone.first.start_long).to_not be_nil
      expect(cyclone.first.stop_lat).to_not be_nil
      expect(cyclone.first.stop_long).to_not be_nil
      expect(cyclone.first.f_scale).to_not be_nil
      expect(cyclone.first.id).to_not be_nil
      expect {cyclone.first.width}.to raise_error
    end
  end

  describe "#complete_cyclone_tracks" do
    it "returns an array of cyclones where complete track is true" do
      cyclone = Cyclone.complete_cyclone_tracks
      expect(cyclone.first.path.complete_track).to be_true
      expect(cyclone.last.path.complete_track).to be_true
      expect(cyclone.joins(:path).where(paths: {complete_track: false})).to be_empty
    end
  end

  describe "#strongest_cyclones_first" do
    it "returns an array of cyclones sorted in descending order of strength" do
      cyclone = Cyclone.all.strongest_cyclones_first
      expect(cyclone.first.f_scale).to eq(5)
      expect(cyclone.last.f_scale).to eq(0)
    end
  end

  describe "#index_map" do
    it "returns info for cyclones for main index map: with complete tracks, sorted strongest first, and pulling info specified in many_cyclone_map_data method. Limited to 500. " do
      cyclone = Cyclone.index_map
      bad_storm = Cyclone.joins(:path).where(paths: {complete_track: false}).first

      expect {cylone.find(bad_storm.id)}.to raise_error
    end
  end

  describe "#historical_data" do
    it "returns a json object from the API call to forecast.io, then returns a json object from the database" do
      expect(HistoricalWeather.first).to be_nil
      cyclone = Cyclone.historical_data(1)
      expect(cyclone["timezone"]).to_not be_nil
      expect(cyclone["currently"]["temperature"]).to_not be_nil

      cyclone = Cyclone.historical_data(1)
      expect(cyclone["timezone"]).to be_nil
      expect(cyclone["currently"]["temperature"]).to_not be_nil
      expect(Cyclone.find(1).historical_weather.length).to be(25)
      expect(HistoricalWeather.first).to_not be_nil
    end
  end

  describe "radius_search" do
    it "returns the number of tornadoes within the selected radius of Loudon, TN" do
      expect(Cyclone.radius_search({"city" => "Loudon", "state" => "TN", "radius" => 5}).count).to eq(0)
      expect(Cyclone.radius_search({"city" => "Loudon", "state" => "TN", "radius" => 10}).count).to eq(2)
      expect(Cyclone.radius_search({"city" => "Loudon", "state" => "TN", "radius" => 15}).count).to eq(7)
    end
  end

  describe "deadly_tornadoes" do
    it "returns only deadly tornadoes in this search" do
      cyclones = Cyclone.deadly_cyclones
      expect(cyclones.first.fatalities).to be > 0
      expect(cyclones.last.fatalities).to be > 0
      expect(cyclones.where(fatalities: 0)).to be_empty
    end
  end

  describe "5 scale tornadoes search" do
    it "returns only 5 scale tornadoes" do
      cyclones = Cyclone.scale_5_cyclones
      expect(cyclones.where('f_scale = 5').count).to eq(cyclones.count)
      expect(cyclones.first.f_scale).to be(5)
    end
  end

  describe "deadliest cyclones first" do
    it "Orders the cyclones returned from deadliest to least deadly" do
      cyclones = Cyclone.deadliest_cyclones_first
      expect(cyclones.first.fatalities).to be >= cyclones.offset(1).first.fatalities
      expect(cyclones.offset(1).first.fatalities).to be >= cyclones.offset(2).first.fatalities
      expect(cyclones.last.fatalities).to eq(0)
    end
  end

  describe "costliest cyclones first" do
    it "Orders the cyclones returned from costliest to least costly" do
      cyclones = Cyclone.costliest_cyclones_first
      expect(cyclones.first.property_loss).to be >= cyclones.offset(1).first.property_loss
      expect(cyclones.offset(1).first.property_loss).to be >= cyclones.offset(2).first.property_loss
      expect(cyclones.last.property_loss).to eq(0)
    end
  end

  describe "Illegal Char Search" do
    it "Checks for illegal chars in parameters" do
      expect(Cyclone.illegal_chars("this should work")).to be(false)
      expect(Cyclone.illegal_chars("!")).to eq("!")
      expect(Cyclone.illegal_chars("f_scale:<=4")).to eq("<")
      expect(Cyclone.illegal_chars("this is [wrong]")).to eq("[")
      expect(Cyclone.illegal_chars("f_scale:4+&state:tn")).to eq("&")
      expect(Cyclone.illegal_chars("f_scale:4@")).to eq("@")
    end
  end

  describe "same day cyclones" do
    it "Given a cyclone id, returns all storms that occurred on the same day" do
      obj = {}
      cyclones = Cyclone.same_day_cyclones({"id" => 586})
      expect(cyclones.first.cyclone_date_id).to eq(cyclones.last.cyclone_date_id)

      cyclones = Cyclone.same_day_cyclones({"id" => 275})
      expect(cyclones.first.cyclone_date_id).to eq(cyclones.last.cyclone_date_id)

      cyclones = Cyclone.same_day_cyclones({"id" => 1380})
      expect(cyclones.first.cyclone_date_id).to eq(cyclones.last.cyclone_date_id)
    end
  end

end
