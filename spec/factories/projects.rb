FactoryGirl.define do
  factory :project do
    sequence(:title) { |i| "Test project ##{i}" }
    association :creator, factory: :user

    trait :with_issues do
      after(:create) do |project|
        project.issues << create(:issue, project: project)
      end
    end

    factory :invalid_project do
      title ''
    end
  end
end