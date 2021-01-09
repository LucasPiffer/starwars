module StarwarsServiceApi
  BASE_URL = "http://swapi.dev/api/".freeze
  include Mechanizable
  include ContractErrors

  def has_next?
    next_url.present?
  end

  def next_url
    @response&.dig('next')
  end

  def get_list!(next_page: nil)
    if next_page.present?
      url = next_page
    else
      url = "#{BASE_URL}#{self.class::RESOURCE}"
    end

    payload = get url

    @response = JSON.parse payload.body

    validate_request_contract! @response

    @response
  end

  def validate_request_contract!(request)
    contract = RequestContract.new.call(request)

    raise RequestBrokenContractError.new unless contract.success?
  end
end
