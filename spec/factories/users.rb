FactoryGirl.define do
  factory :user, aliases: [:creator] do
    sequence(:email) { |i| "test#{i}@email.com" }
    password 'password'
    password_confirmation 'password'
  end
end