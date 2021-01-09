require 'rails_helper'

RSpec.describe PeopleService, type: :service do
  describe '.save_all' do
    let(:planet) do
      create(:planet).url
    end

    let(:starcrafts) do
      starcract_one = create(:starcraft, name: "Xyz", model: "ZZZ")
      starcract_two = create(:starcraft, name: "ZZy", model: "Xyz")

      [starcract_one.url, starcract_two.url]
    end

    let(:species) do
      species_one = create(:species)
      species_two = create(:species)

      [species_one.url, species_two.url]
    end

    context 'when API is compliant with contract and has pagination' do
      let(:first_ten) do
        1.upto(10).map do |i|
          {
            'name' => Faker::Movies::StarWars.character,
            'url' => "https://swapi.dev/api/people/#{i}",
            'homeworld' => planet,
            'species' => species,
            'starships' => starcrafts
          }
        end
      end

      let(:last_three) do
        11.upto(13).map do |i|
          {
            'name' => Faker::Movies::StarWars.character,
            'url' => "https://swapi.dev/api/people/#{i}",
            'homeworld' => planet,
            'species' => species,
            'starships' => starcrafts
          }
        end
      end

      it 'creates all records' do
        allow_any_instance_of(Mechanize)
          .to receive(:get)
                .with('http://swapi.dev/api/people')
                .and_return(
                  double(body: {
                    results: first_ten,
                    next: 'http://swapi.dev/api/people?page=2'
                  }.to_json)
                )

        allow_any_instance_of(Mechanize)
          .to receive(:get).with('http://swapi.dev/api/people?page=2')
                .and_return(
                  double(body: {
                    results: last_three,
                    next: ''
                  }.to_json)
                )

        expect { described_class.save_all }.to change { Person.count }.by(13)

        people = Person.first

        expect(people.planet.url).to eq planet
        expect(people.starcrafts.size).to eq 2
        expect(people.species.size).to eq 2
      end
    end

    context 'when API changes breaking contract' do

    end
  end
end
