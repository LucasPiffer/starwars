FactoryBot.define do
  factory :planet do
    name { Faker::Movies::StarWars.planet }
    url { 'http://swapi.dev/api/planets/1' }
  end
end
