FactoryBot.define do
  factory :article do
    title { "How to train your dragon" }
    description { "Ever wonder how?" }
    body { "You have to believe" }
    user
  end
end
