FactoryBot.define do
  factory :starcraft do
    sequence :name do |n|
      "#{Faker::Movies::StarWars.vehicle}#{n}"
    end

    sequence :url do |n|
      "http://swapi.dev/api/starship/#{n}"
    end
  end
end

