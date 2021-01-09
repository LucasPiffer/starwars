class PeopleService
  include ContractErrors

  def self.save_all(raise: false)
    request = PeopleServiceApi.new

    get_all_people_from_api(request, raise: raise)
  end

  def self.save_all!
    save_all(raise: true)
  end

  def self.get_all_people_from_api(request, next_url: nil, raise: false)
    response = request.get_list!(next_page: next_url)

    response['results'].each do |result|
      persist_item(result, raise: raise)
    end

    self.get_all_people_from_api(request, next_url: request.next_url, raise: raise) if request.has_next?
  end

  def self.persist_item(person, raise: false)
    person_contract = PersonContract.new.call(person)

    if person_contract.success?
      puts "Going to find or save #{person}".green

      PeopleBuilder.new(person)
        .set_starcrafts
        .set_species
        .save
    else
      puts "Record #{person} is not contract compliant".red

      if raise == true
        raise EnityBrokenContractError.new "Record breaks contract"
      end
    end
  end
end
