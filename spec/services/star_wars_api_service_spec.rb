require 'rails_helper'

RSpec.describe StarWarsService, type: :service do
  describe 'People' do
    describe '#get_list' do
      let(:next_page) { nil }

      subject { StarWars::People.new.get_list(next_page: next_page) }

      context 'when the request responds with the expected result' do
        context 'when next page is not present' do
          it 'responds with a Hash containing count, next, previous' do
            VCR.use_cassette("people_get_list") do
              response = subject

              expect(response).to be_a Hash
            end
          end

          context 'when next page is present' do

          end
        end
      end

      context 'any status code different than 20#' do

      end
    end
  end
end
