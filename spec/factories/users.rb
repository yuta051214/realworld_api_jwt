FactoryBot.define do
  factory :user do
    username { "foo bar" }
    email { "test1@test.com" }
    password { "password" }
  end
end
