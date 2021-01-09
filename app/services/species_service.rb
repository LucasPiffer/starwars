class SpeciesService
  def self.save_all
    request = SpeciesServiceApi.new

    get_all_species_from_api(request) do |species_item|
      persist_item(species_item)
    end
  end

  def self.get_all_species_from_api(request, next_url: nil)
    response = request.get_list!(next_page: next_url)

    response['results'].each do |result|
      persist_item(result)
    end

    self.get_all_species_from_api(request, next_url: request.next_url) if request.has_next?
  end

  def self.persist_item(species_item)
    species_contract = SpeciesContract.new.call(species_item)

    if species_contract.success?
      puts "Going to find or save #{species_item}".green

      Species.find_or_create_by!(species_item.slice("name", "url"))
    else
      puts "Record #{species_item} is not contract compliant".red
    end
  end
end
