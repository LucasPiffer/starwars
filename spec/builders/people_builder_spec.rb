require 'rails_helper'

RSpec.describe PeopleBuilder, type: :builder do
  context 'save people' do
    it 'saves people and associates with planet' do
      planet = create(:planet)
      character = Faker::Movies::StarWars.character

      PeopleBuilder
        .new(
          {
            'name' => character,
            'url' => 'http://swapi.dev/api/people/3',
            'homeworld' => planet.url
          })
        .save

      people = Person.last

      expect(people.name).to eq character
      expect(people.planet).to eq planet
    end
  end

  context 'set set_starcrafts and save people' do
    it 'saves people and associates with planet and starcrafts' do
      planet = create(:planet)
      starcract_one = create(:starcraft, name: "Xyz", model: "ZZZ")
      starcract_two = create(:starcraft, name: "ZZy", model: "Xyz")

      character = Faker::Movies::StarWars.character

      PeopleBuilder
        .new(
          {
            'name' => character,
            'url' => 'http://swapi.dev/api/people/3',
            'homeworld' => planet.url,
            'starships' => [
              starcract_one.url,
              starcract_two.url,
              starcract_two.url
            ]
          })
        .set_starcrafts
        .save

      people = Person.last

      expect(people.name).to eq character
      expect(people.planet).to eq planet
      expect(people.starcrafts.count).to eq 2
      expect(people.starcrafts.pluck(:id).sort).to eq [starcract_one.id, starcract_two.id]
    end
  end

  context 'set set_species and save people' do
    it 'saves people and associates with planet and starcrafts' do
      planet = create(:planet)
      species_one = create(:species)
      species_two = create(:species)

      character = Faker::Movies::StarWars.character

      PeopleBuilder
        .new(
          {
            'name' => character,
            'url' => 'http://swapi.dev/api/people/3',
            'homeworld' => planet.url,
            'species' => [
              species_one.url,
              species_two.url
            ]
          })
        .set_species
        .save

      people = Person.last

      expect(people.name).to eq character
      expect(people.planet).to eq planet
      expect(people.species.count).to eq 2
      expect(people.species.pluck(:id).sort).to eq [species_one.id, species_two.id]
    end
  end
end
