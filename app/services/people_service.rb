class PeopleService
  def self.save_all
    people = get_all_people_from_api

    people.each do |person|
      person_contract = PersonContract.new.call(person)

      PeopleBuilder.new(person)
        .set_planet
        .set_starcrafts
        .set_species
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
