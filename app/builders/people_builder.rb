class PeopleBuilder
  def initialize(person_structure)
    @name = person_structure['name']
    @url = person_structure['url']
    @mass = person_structure['mass']
    @ext_id = person_structure['url'].match(/people\/(\d+)/)[1]
    @birth_year = person_structure['birth_year']
    @homeworld_url = person_structure['homeworld']
    @species_urls = person_structure['species']
    @starcrafts_urls = person_structure['starships']
  end

  def set_starcrafts
    @starcrafts = @starcrafts_urls.map do |url|
      Starcraft.find_by(url: url)
    end.compact

    self
  end

  def set_species
    @species = @species_urls.map do |url|
      Species.find_by(url: url)
    end.compact

    self
  end

  def save
    planet = Planet.find_by url: @homeworld_url

    person = Person.find_or_create_by!(
      name: @name,
      url: @url,
      mass: @mass,
      birth_year: @birth_year,
      ext_id: @ext_id,
      planet: planet
    )

    save_starcrafts(person) if @starcrafts.present?
    save_species(person) if @species.present?
  end

  def save_starcrafts(person)
    @starcrafts.each do |starcraft|
      person.starcrafts << starcraft
    end
  end

  def save_species(person)
    @species.each do |starcraft|
      person.species << starcraft
    end
  end
end
