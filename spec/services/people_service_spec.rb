require 'rails_helper'

RSpec.describe PeopleService, type: :service do
  describe '.save_all' do
    context 'when API is compliant with contract and has pagination' do
      let(:first_ten) do
        1.upto(10).map do |i|
          {
            'name' => Faker::Movies::StarWars.character,
            'url' => "https://swapi.dev/api/people/#{i}",
            'homeworld' => "https://swapi.dev/api/planets/#{i}",
            'species' => [
              "https://swapi.dev/api/species/#{i}",
              "https://swapi.dev/api/species/#{i + 1}",
            ],
            'starships' => [
              "https://swapi.dev/api/spaceships/#{i}",
            ]
          }
        end
      end

      let(:last_three) do
        11.upto(13).map do |i|
          {
            'name' => Faker::Movies::StarWars.character,
            'url' => "https://swapi.dev/api/people/#{i}",
            'homeworld' => "https://swapi.dev/api/planets/#{i}",
            'species' => [
              "https://swapi.dev/api/species/#{i}",
              "https://swapi.dev/api/species/#{i + 1}",
            ],
            'starships' => [
              "https://swapi.dev/api/spaceships/#{i}",
            ]
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

      end
    end

    context 'when API changes breaking contract' do

    end
  end
end
