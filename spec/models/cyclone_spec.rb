require 'spec_helper'
require 'rake'
require 'pry'

describe Cyclone do

	before(:each) do
		StormChaser::Application.load_tasks
		Rake::Task.define_task(:environment)
		Rake::Task['import:only_5s'].invoke
	end

  describe "#many_cyclone_map_data" do
  	it "returns an array of objects holding tornado data" do
    	@cyclone = Cyclone.all.limit(10).many_cyclone_map_data

      expect(@cyclone.first.start_lat).to_not be_nil
      expect {@cyclone.first.width}.to raise_error
      expect(@cyclone.length).to be(10)
  	end
  end

  describe "#index_map" do
  	it "returns all storms with a complete path " do
    	@cyclone = Cyclone.index_map
    	@bad_storm = Cyclone.joins(:path).where(paths: {complete_track: false}).first

      expect {@cylone.find(@bad_storm.id)}.to raise_error
  	end
  end

end
