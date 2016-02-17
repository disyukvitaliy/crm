FactoryGirl.define do
  factory :issue_status do
    sequence(:title) { |i| "Test issue status ##{i}" }

    factory :activated_issue_status do
      status 1
    end
  end
end