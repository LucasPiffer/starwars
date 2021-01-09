class SpeciesServiceApi
  BASE_URL = "http://swapi.dev/api/".freeze
  include Mechanizable

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
      url = "#{BASE_URL}species"
    end

    payload = get url

    @response = JSON.parse payload.body

    validate_request_contract! @response

    @response
  end

  def validate_request_contract!(request)
    RequestContract.new.call(request)
  end
end