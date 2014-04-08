# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :avg_cyclone_datum, :class => 'AvgCycloneData' do
    year "MyString"
    fatalities 1.5
    property_loss 1.5
    crop_loss 1.5
    injuries 1.5
    distance 1.5
    f_scale 1.5
  end
end
