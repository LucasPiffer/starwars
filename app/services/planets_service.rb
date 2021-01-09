class PlanetsService
  def self.save_all
    request = PlanetsServiceApi.new

    get_all_planets_from_api(request) do |species_item|
      persist_item(species_item)
    end
  end

  def self.get_all_planets_from_api(request, next_url: nil)
    response = request.get_list!(next_page: next_url)

    response['results'].each do |result|
      persist_item(result)
    end

    self.get_all_planets_from_api(request, next_url: request.next_url) if request.has_next?
  end

  def self.persist_item(planet_item)
    planet_contract = PlanetContract.new.call(planet_item)

    if planet_contract.success?
      puts "Going to find or save #{planet_item}".green

      Planet.find_or_create_by!(planet_item.slice("name", "url"))
    else
      puts "Record #{planet_item} is not contract compliant".red
    end
  end
end
