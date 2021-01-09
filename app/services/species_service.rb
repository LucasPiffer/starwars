class SpeciesService
  def self.save_all!
    save_all(raise_error: true)
  end

  def self.save_all(raise_error: false)
    request = SpeciesServiceApi.new

    get_all_species_from_api(request, raise_error: raise_error)
  end

  def self.get_all_species_from_api(request, next_url: nil, raise_error: false)
    response = request.get_list!(next_page: next_url)

    response['results'].each do |result|
      persist_item(result, raise_error)
    end

    self.get_all_species_from_api(request, next_url: request.next_url, raise_error: raise_error) if request.has_next?
  end

  private

  def self.persist_item(species_item, raise_error)
    species_contract = SpeciesContract.new.call(species_item)

    if species_contract.success?
      puts "Going to find or save #{species_item}".green

      Species.find_or_create_by!(species_item.slice("name", "url"))
    else
      puts "Record #{species_item} is not contract compliant".red

      if raise_error == true
        raise EnityBrokenContractError.new "Species Record breaks contract"
      end
    end
  end
end
