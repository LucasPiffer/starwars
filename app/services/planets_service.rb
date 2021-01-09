class PlanetsService
  def self.save_all!
    save_all(raise_error: true)
  end

  def self.save_all(raise_error: false)
    request = PlanetsServiceApi.new

    get_all_planets_from_api(request, raise_error: true)
  end

  def self.get_all_planets_from_api(request, next_url: nil, raise_error: false)
    response = request.get_list!(next_page: next_url)

    response['results'].each do |result|
      persist_item(result, raise_error: raise_error)
    end

    self.get_all_planets_from_api(request, next_url: request.next_url, raise_error: raise_error) if request.has_next?
  end

  def self.persist_item(planet_item, raise_error: false)
    planet_contract = PlanetContract.new.call(planet_item)

    if planet_contract.success?
      puts "Going to find or save #{planet_item}".green

      Planet.find_or_create_by!(planet_item.slice("name", "url"))
    else
      puts "Record #{planet_item} is not contract compliant".red

      if raise_error == true
        raise EnityBrokenContractError.new "Planet Record breaks contract"
      end
    end
  end

  private_class_method :persist_item
end
