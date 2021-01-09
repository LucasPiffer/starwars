FactoryBot.define do
  factory :starcraft do
    name { Faker::Movies::StarWars.vehicle }
    sequence :url do |n|
      "http://swapi.dev/api/starship/#{n}"
    end
  end
end

