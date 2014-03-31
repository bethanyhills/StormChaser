require 'spec_helper'
require 'rake'
require 'pry'
# load './lib/tasks/import.rake'

describe Storm do

	before(:each) do 
		StormChaser::Application.load_tasks
		Rake::Task.define_task(:environment)
		# Rake::Task['db:drop'].invoke
		# Rake::Task['db:create'].invoke
		# Rake::Task['db:migrate'].invoke
		Rake::Task['import:only_5s'].invoke
		@storm = Storm.all.limit(10).many_storm_map_data()
	end

describe "#many_storm_map_data" do
	it "returns an array of objects holding tornado data" do

   expect(@storm.first.start_lat).to_not be_nil
   expect {@storm.first.width}.to raise_error
   expect(@storm.length).to be(10)
	end
end
end
