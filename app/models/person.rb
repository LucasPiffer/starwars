class Person < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true, uniqueness: true

  belongs_to :planet
  has_and_belongs_to_many :species, -> { distinct }
  has_and_belongs_to_many :starcrafts, -> { distinct }
end
