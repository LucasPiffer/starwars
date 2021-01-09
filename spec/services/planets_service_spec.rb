require 'rails_helper'

RSpec.describe PlanetsService, type: :service do
  describe '.save_all' do
    context 'when API is compliant with contract and has pagination' do
      let(:first_ten) do
        1.upto(10).map do |i|
          {
            'name' => Faker::Name.name,
            'url' => "https://swapi.dev/api/planets/#{i}"
          }
        end
      end

      let(:last_three) do
        11.upto(13).map do |i|
          {
            'name' => Faker::Name.name,
            'url' => "https://swapi.dev/api/planets/#{i}"
          }
        end
      end

      it 'creates all records' do
        allow_any_instance_of(Mechanize).to receive(:get).with('http://swapi.dev/api/planets').and_return(
          double(body: {
            results: first_ten,
            next: 'http://swapi.dev/api/planets?page=2'
          }.to_json)
        )

        allow_any_instance_of(Mechanize).to receive(:get).with('http://swapi.dev/api/planets?page=2').and_return(
          double(body: {
            results: last_three,
            next: ''
          }.to_json)
        )

        expect { described_class.save_all }.to change { Planet.count }.by(13)
      end
    end

    context 'when API changes breaking contract' do

    end
  end
end


