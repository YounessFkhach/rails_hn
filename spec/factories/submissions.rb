FactoryBot.define do
  factory :submission do
    title { Faker::Lorem.sentence }
    link { Faker::Internet.url }
    body { Faker::Lorem.paragraph }
    user_id nil
  end
end