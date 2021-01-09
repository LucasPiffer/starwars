class Species < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  
  has_and_belongs_to_many :people
end
