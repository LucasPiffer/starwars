class PeopleService
  def self.save_all
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

    PeopleBuilder.build(people.flatten)
  end
end
