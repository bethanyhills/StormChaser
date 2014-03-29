# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :path do
    states_crossed 1
    complete_track false
    segment_num 1
  end
end
