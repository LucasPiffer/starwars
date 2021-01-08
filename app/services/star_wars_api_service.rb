module StarWarsService
  BASE_URL = "http://swapi.dev/api/".freeze

  class People
    include Mechanizable

    def get_list!(next_page: nil)
      if next_page.present?
        url = next_page
      else
        url = "#{BASE_URL}people"
      end

      response = get url

      response = JSON.parse response.body

      validate_request_contract! request

      response
    end

    def validate_request_contract!(request)
      PeopleRequestContract.new.call(request)
    end
  end
end
