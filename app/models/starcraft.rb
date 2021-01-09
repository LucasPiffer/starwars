class Starcraft < ApplicationRecord
  validates :name, :model, presence: true
  validates :url, presence: true, uniqueness: true

  validates_uniqueness_of :name, scope: %i(model)
  has_and_belongs_to_many :people
end
