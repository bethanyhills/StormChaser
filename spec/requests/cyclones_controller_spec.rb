require 'spec_helper'
require 'rake'
require 'pry'

describe "Cyclones API" do

  describe "Cyclone by ID" do
    it 'Grabs individual storm data' do
      get '/api/v1/cyclones/1', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body["cyclone_strength"]["f_scale"]).to eq(3)
      expect(body["date"]["day"]).to eq(1)
      expect(body["date"]["year"]).to eq(2011)
      expect(body["loss"]["fatalities"]).to eq(0)
      expect(body["path"]["segment_num"]).to eq(1)
    end
  end

  describe "Cyclones by api/v1/cyclones" do
    it 'Grabs 500 cyclones from /api/v1/cyclones' do
      get '/api/v1/cyclones', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(500)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(5)
      expect(body[0]["date"]["day"]).to eq(27)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(72)
      expect(body[0]["path"]).to be(nil)
      expect(body[0]["id"]).to eq(790)
    end
  end

  describe "Cyclones by state" do
    it 'Grabs the cyclones from TN by /api/v1/cyclones/state:tn' do
      get '/api/v1/cyclones/state:tn', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(103)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(2)
      expect(body[0]["date"]["day"]).to eq(24)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["id"]).to eq(28)
    end
  end

  describe "Cyclones by F-Scale" do
    it 'Grabs only cyclones with an F-Scale of 5' do
      get '/api/v1/cyclones/f_scale:5', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(9)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(5)
      expect(body[0]["date"]["day"]).to eq(27)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(3)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["id"]).to eq(781)

    end

    it 'Grabs cyclones with an F-Scale of 4 & 5' do
      get '/api/v1/cyclones/f_scale:4+', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(34)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(4)
      expect(body[0]["date"]["day"]).to eq(9)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["id"]).to eq(230)

      expect(body[27]["cyclone_strength"]["f_scale"]).to eq(5)
      expect(body[27]["date"]["day"]).to eq(22)
      expect(body[27]["date"]["year"]).to eq(2011)
      expect(body[27]["loss"]["fatalities"]).to eq(158)
      expect(body[27]["path"]["segment_num"]).to eq(1)
      expect(body[27]["id"]).to eq(1066)
    end
  end

  describe "Cyclones by fatalities" do
    it 'Grabs the cyclone in 2011 that had 158 casualties' do
      get '/api/v1/cyclones/fatalities:158', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(1)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(5)
      expect(body[0]["date"]["day"]).to eq(22)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(158)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["id"]).to eq(1066)
    end

    it 'Grabs all cyclones that had a casualty' do
      get '/api/v1/cyclones/fatalities:1+', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(73)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(2)
      expect(body[0]["date"]["day"]).to eq(28)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(1)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["id"]).to eq(72)
    end
  end

  describe "Cyclones by month" do
    it 'Grabs all cyclones that happened in the month of Feb' do
      get '/api/v1/cyclones/month:2', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(66)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(0)
      expect(body[0]["date"]["day"]).to eq(1)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["id"]).to eq(19)
    end

    it 'Grabs all cyclones that happened in the months of Oct, Nov and Dec' do
      get '/api/v1/cyclones/month:10+', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(89)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(0)
      expect(body[0]["date"]["day"]).to eq(5)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["id"]).to eq(1676)
    end
  end

  describe "Cyclones by day" do
    it 'Grabs all cyclones that happened on the 13th of the month' do
      get '/api/v1/cyclones/day:13', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(16)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(0)
      expect(body[0]["date"]["day"]).to eq(13)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["id"]).to eq(997)
    end

    it 'Grabs all cyclones that happened before or on the third of the month' do
      get '/api/v1/cyclones/day:3-', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(48)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(1)
      expect(body[0]["date"]["day"]).to eq(1)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["id"]).to eq(7)
    end
  end

  describe "Cyclones by hour" do
    it 'Grabs all cyclones that happened on or after 20 (8 PM)' do
      get '/api/v1/cyclones/hour:20+', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(278)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(0)
      expect(body[0]["date"]["day"]).to eq(25)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["id"]).to eq(16)
    end

    it 'Grabs all cyclones that happened on or before 4 (4 AM)' do
      get '/api/v1/cyclones/hour:4-', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(147)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(3)
      expect(body[0]["date"]["day"]).to eq(1)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["id"]).to eq(1)
    end
  end

  describe "Cyclones by Crop Loss" do
    it 'Grabs crop loss at 1 million or above' do
      get '/api/v1/cyclones/crop_loss:1+', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(11)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(3)
      expect(body[0]["date"]["day"]).to eq(1)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["loss"]["crop_loss"]).to eq(2)
      expect(body[0]["id"]).to eq(1)
    end

    it 'Grabs crop loss at 3 million or above' do
      get '/api/v1/cyclones/crop_loss:3+', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(1)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(1)
      expect(body[0]["date"]["day"]).to eq(15)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["loss"]["crop_loss"]).to eq(3)
      expect(body[0]["id"]).to eq(325)
    end
  end

  describe "Cyclones by Injuries" do
    it 'Grabs cyclones that have at least 1 injury' do
      get '/api/v1/cyclones/injuries:1+', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(185)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(3)
      expect(body[0]["date"]["day"]).to eq(1)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["loss"]["injuries"]).to eq(2)
      expect(body[0]["id"]).to eq(1)
    end

    it 'Grabs cyclones that have 1 injury' do
      get '/api/v1/cyclones/injuries:1', {}, { "Accept" => "application/json" }
      body = JSON.parse(response.body)

      expect(response).to be_success
      expect(body.length).to eq(42)
      expect(body[0]["cyclone_strength"]["f_scale"]).to eq(3)
      expect(body[0]["date"]["day"]).to eq(1)
      expect(body[0]["date"]["year"]).to eq(2011)
      expect(body[0]["loss"]["fatalities"]).to eq(0)
      expect(body[0]["path"]["segment_num"]).to eq(1)
      expect(body[0]["loss"]["injuries"]).to eq(1)
      expect(body[0]["id"]).to eq(6)
    end
  end


end
