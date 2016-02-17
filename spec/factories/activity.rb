FactoryGirl.define do
  factory :activity do
    sequence(:title) { |i| "Test activity ##{i}" }

    factory :activated_activity do
      status 1
    end
  end
end