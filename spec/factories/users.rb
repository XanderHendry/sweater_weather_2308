FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "Password" }
    password_confirmation{ "Password"}
    api_key { nil }
  end
end
