FactoryGirl.define do
  factory :time_entry do
    date DateTime.now
    amount '1.3'
    association :issue
    association :user
    association :activity
  end
end