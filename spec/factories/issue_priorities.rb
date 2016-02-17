FactoryGirl.define do
  factory :issue_priority do
    sequence(:title) { |i| "Test issue priority ##{i}" }

    factory :activated_issue_priority do
      status 1
    end
  end
end