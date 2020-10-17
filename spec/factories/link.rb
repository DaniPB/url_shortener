FactoryBot.define do
  factory :link do
    address { Faker::Internet.url('example.com') }
    short   { Faker::Lorem.characters(10) }
    visits  { Faker::Number.number(1) }
  end
end
