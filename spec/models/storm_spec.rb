require 'spec_helper'
require 'rake'
require 'pry'
# load './lib/tasks/import.rake'

describe Storm do

	# before(:each) do
	# 	StormChaser::Application.load_tasks
	# 	Rake::Task.define_task(:environment)
	# 	Rake::Task['import:only_5s'].invoke
	# end

describe "#many_storm_map_data" do
	it "returns an array of objects holding tornado data" do
	@storm = Storm.all.limit(10).many_storm_map_data()

   expect(@storm.first.start_lat).to_not be_nil
   expect {@storm.first.width}.to raise_error
   expect(@storm.length).to be(10)
	end
end

describe "#index_map" do
	it "returns all storms with a complete path " do
	@storm = Storm.index_map
	@bad_storm = Storm.joins(:path).where(paths: {complete_track: false}).first

   expect {@storm.find(@bad_storm.id)}.to raise_error
	end
end

end
