class Starcraft < ApplicationRecord
  validates :name, :model, presence: true
  validates_uniqueness_of :name, scope: %i(model)
  has_and_belongs_to_many :people
end
