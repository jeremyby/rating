# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :polling_number do
    poll_id 1
    positive_count 1
    negative_count 1
  end
end
