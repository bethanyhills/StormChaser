# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :historical_weather do
    wind_speed 1.5
    wind_bearing 1.5
    temperature 1.5
    pressure 1.5
    hour 1
    cyclone nil
  end
end
