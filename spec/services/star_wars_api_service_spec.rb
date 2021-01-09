require 'rails_helper'

RSpec.describe StarWarsApiService, type: :service do
  describe 'Species' do
    describe '#get_list' do
      let(:next_page) { nil }

      subject { StarWarsApiService::Species.new.get_list!(next_page: next_page) }

      context 'API responds with success' do
        it 'responds with a Hash containing count, next, previous' do
          VCR.use_cassette("species_get_list") do
            response = subject

            expect(response).to be_a Hash
            expect(response.keys.include?('results')).to be_truthy
          end
        end
      end
    end
  end
end
