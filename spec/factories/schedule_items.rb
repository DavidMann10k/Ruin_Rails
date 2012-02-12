# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule_item do
    day "MyString"
    start_hour 1
    duration 1
  end
end
