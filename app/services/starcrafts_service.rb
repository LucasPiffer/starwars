class StarcraftsService
  def self.save_all!
    save_all(raise_error: true)
  end

  def self.save_all(raise_error: false)
    request = StarcraftsServiceApi.new

    get_all_starcrafts_from_api(request, raise_error: raise_error)
  end

  def self.get_all_starcrafts_from_api(request, next_url: nil, raise_error: false)
    response = request.get_list!(next_page: next_url)

    response['results'].each do |result|
      persist_item(result, raise_error)
    end

    self.get_all_starcrafts_from_api(request, next_url: request.next_url) if request.has_next?
  end

  private

  def self.persist_item(starcrafts_item, raise_error)
    starcrafts_contract = StarcraftContract.new.call(starcrafts_item)

    if starcrafts_contract.success?
      puts "Going to find or save #{starcrafts_item}".green

      Starcraft.find_or_create_by!(starcrafts_item.slice("name", "model", "url"))
    else
      puts "Record #{starcrafts_item} is not contract compliant".red

      if raise_error == true
        raise EnityBrokenContractError.new "Starcraft Record breaks contract"
      end
    end
  end
end
