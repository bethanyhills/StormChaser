require 'spec_helper'
require 'rake'
require 'pry'

describe CyclonesController do

  StormChaser::Application.load_tasks
  Rake::Task.define_task(:environment)
  Rake::Task['import:only_5s'].invoke

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    it "renders the index template" do
      get 'index'
      expect(response).to render_template("index")
    end  
  end

  describe "GET 'show'" do
    cyclones = Cyclone.all
    x = cyclones.first
    it "returns http success" do
      get :show, id: x.id
      response.should be_success
    end
    it "renders the show template" do
      get :show, id: x.id
      expect(response).to render_template("show")
    end  
  end

   describe "GET 'hist_weather_api'" do
    
  end

   describe "GET 'search_radius'" do
    it "returns http success" do
      get 'search_radius'
      response.should be_success
    end
  end

   describe "GET 'search_api_call'" do
    
  end

end
