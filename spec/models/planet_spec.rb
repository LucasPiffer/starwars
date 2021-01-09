require 'rails_helper'

RSpec.describe Planet, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :url }
    it { should validate_uniqueness_of :name }
    it { should validate_uniqueness_of :url }
  end

  describe 'associations' do
    it { should have_many :people }
  end
end
