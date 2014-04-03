# Read about factories at https//github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cyclone do |x|
    x.cyclone_date nil
    x.path nil
		x.county_code_four 185
		x.county_code_one 1
		x.county_code_three 81 
		x.county_code_two 35 
		x.created_at "2014-03-31T171729.906Z" 
		x.crop_loss 0 
		x.distance 79.7 
		x.f_scale 5 
		x.fatalities 4 
		x.hour 18 
		x.id 23 
		x.injuries 50 
		x.minute 30 
		x.path_id 1 
		x.property_loss 6 
		x.start_lat 40.55 
		x.start_long -98.37 
		x.state "NE" 
		x.stop_lat 41.35 
		x.stop_long -97.27 
		x.time_zone 3 
		x.tornado_date_id 14  
		x.updated_at "2014-03-31T171729.906Z" 
		x.width 880
  end
end
