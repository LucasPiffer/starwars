class PeopleBuilder
  def initialize(person_structure)
    @person_structure = person_structure
  end

  def add_planets(planets_structure)

    self
  end

  def add_spaceship(spaceships_structure)

    self
  end

  def add_species(species_structure)

    self
  end

  def save

  end

  def self.validate_people_contract!(people)
    PeopleContract.new.call(people)
  end
end
