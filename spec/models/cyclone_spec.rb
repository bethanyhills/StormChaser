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
    it "returns a json object from the API call to forecast.io" do
      cyclone = Cyclone.historical_data(1)
      # p cyclone
      expect(cyclone["timezone"]).to_not be_nil
      expect(cyclone["currently"]["temperature"]).to_not be_nil

      cyclone = Cyclone.historical_data(1)
      expect(cyclone["timezone"]).to be_nil
      expect(cyclone["currently"]["temperature"]).to_not be_nil
    end
  end

  describe "radius_search" do
    it "returns true if tornado is within selected radius" do
      # cyclone = Cyclone.radius_search({city: "Loudon", state: "TN", radius: 10})
      p Cyclone.radius_search({"city" => "Loudon", "state" => "TN", "radius" => 10}).first.cyclone_date
      expect(Cyclone.radius_search({"city" => "Loudon", "state" => "TN", "radius" => 5}).count).to eq(0)
      expect(Cyclone.radius_search({"city" => "Loudon", "state" => "TN", "radius" => 10}).count).to eq(1)



    # expect(x).to be_true
    end
  end

end
