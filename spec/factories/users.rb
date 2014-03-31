# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |u|
	u.name "test"
	u.sequence(:email) { |n| "mike#{n}@email.com"}
	u.password "password"
	end
  end
end
