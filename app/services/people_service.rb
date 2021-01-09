class PeopleService
  include ContractErrors

  def self.save_all(raise_error: false)
    request = PeopleServiceApi.new

    get_all_people_from_api(request, raise_error: raise_error)
  end

  def self.save_all!
    save_all(raise_error: true)
  end

  def self.get_all_people_from_api(request, next_url: nil, raise_error: false)
    response = request.get_list!(next_page: next_url)

    response['results'].each do |result|
      persist_item(result, raise_error)
    end

    self.get_all_people_from_api(request, next_url: request.next_url, raise_error: raise_error) if request.has_next?
  end

  def self.persist_item(person, raise_error)
    person_contract = PersonContract.new.call(person)

    if person_contract.success?
      puts "Going to find or save #{person}".green

      PeopleBuilder.new(person)
        .set_starcrafts
        .set_species
        .save
    else
      puts "Record #{person} is not contract compliant".red

      if raise_error == true
        raise EnityBrokenContractError.new "People Record breaks contract"
      end
    end
  end

  private_class_method :persist_item
end
