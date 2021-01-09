FactoryBot.define do
  factory :species do
    name { Faker::Movies::StarWars.specie }
    sequence :url do |n|
      "http://swapi.dev/api/species/#{n}"
    end
  end
end

