class StarcraftsService
  def self.save_all
    request = StarcraftsServiceApi.new

    get_all_starcrafts_from_api(request) do |starcrafts_item|
      persist_item(starcrafts_item)
    end
  end

  def self.get_all_starcrafts_from_api(request, next_url: nil)
    response = request.get_list!(next_page: next_url)

    response['results'].each do |result|
      persist_item(result)
    end

    self.get_all_starcrafts_from_api(request, next_url: request.next_url) if request.has_next?
  end

  def self.persist_item(starcrafts_item)
    starcrafts_contract = StarcraftContract.new.call(starcrafts_item)

    if starcrafts_contract.success?
      puts "Going to find or save #{starcrafts_item}".green

      Starcraft.find_or_create_by!(starcrafts_item.slice("name", "model", "url"))
    else
      puts "Record #{starcrafts_item} is not contract compliant".red
    end
  end
end
