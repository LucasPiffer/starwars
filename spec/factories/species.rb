FactoryBot.define do
  factory :species do
    sequence :name do |n|
      "#{Faker::Movies::StarWars.specie}#{n}"
    end

    sequence :url do |n|
      "http://swapi.dev/api/species/#{n}"
    end
  end
end

