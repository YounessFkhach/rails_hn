# spec/factories/todos.rb
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    facebook_id { "adlfasdfasd" }
  end
end