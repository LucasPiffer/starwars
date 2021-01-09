class Person < ApplicationRecord
  validates :name, presence: true

  belongs_to :planet
  has_and_belongs_to_many :species
  has_and_belongs_to_many :starcrafts
end
