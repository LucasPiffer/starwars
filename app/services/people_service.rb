class PeopleService
  def self.save_all
    request = PeopleServiceApi.new

    get_all_people_from_api(request) do |people_item|
      persist_item(people_item)
    end
  end

  def self.get_all_people_from_api(request, next_url: nil)
    response = request.get_list!(next_page: next_url)

    response['results'].each do |result|
      persist_item(result)
    end

    self.get_all_people_from_api(request, next_url: request.next_url) if request.has_next?
  end

  def self.persist_item(person)
    person_contract = PersonContract.new.call(person)

    if person_contract.success?
      puts "Going to find or save #{person}".green

      PeopleBuilder.new(person)
        .set_starcrafts
        .set_species
        .save
    else
      puts "Record #{person} is not contract compliant".red
    end
  end
end
