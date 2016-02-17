FactoryGirl.define do
  factory :issue do
    sequence(:subj) { |i| "Test issue ##{i}" }
    sequence(:descr) { |i| "Test issue description ##{i}" }
    estimated_time '1.2'
    association :issue_priority
    association :issue_status
    association :user
    association :project

    trait :with_time_entries do
      after(:create) do |issue|
        issue.time_entries << create(:time_entry, issue: issue)
      end
    end
  end
end