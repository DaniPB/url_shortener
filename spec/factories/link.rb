FactoryBot.define do
  factory :link do
    address     { Faker::Internet.url('example.com') }
    shortcut    { Faker::Lorem.characters(10) }
    new_address { "https://mydomain/#{shortcut}" }
    visits      { Faker::Number.number(1) }
  end
end
