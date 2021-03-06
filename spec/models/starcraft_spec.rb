require 'rails_helper'

RSpec.describe Starcraft, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :model }
    it { should validate_presence_of :url }
    it { should validate_uniqueness_of(:name).scoped_to(:model) }
    it { should validate_uniqueness_of(:url) }
  end

  describe 'associations' do
    it { should have_and_belong_to_many :people }
  end
end
