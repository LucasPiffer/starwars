class PeopleService
  def self.save_all
    people = get_all_people_from_api

    people.flatten.each do |person|
      planet_request = StarWarsApiService::Planets.new
      spaceship_request = StarWarsApiService::Spaceships.new
      species_request = StarWarsApiService::Species.new

      PeopleBuilder.new(person)
        .add_planets(planet_request)
        .add_spaceship(spaceship_request)
        .add_species(species_request)
        .save
    end
  end

  def self.get_all_people_from_api
    people = []
    next_url = ''

    request = StarWarsApiService::People.new

    response = request.get_list!
    people << response['results']

    while response['next'].present? && response['next'] != next_url
      next_url = response['next']
      response = request.get_list!(next_page: next_url)

      people << response['results']
    end

    people.flatten
  end
end
