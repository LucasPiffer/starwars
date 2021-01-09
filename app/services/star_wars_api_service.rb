module StarWarsApiService
  BASE_URL = "http://swapi.dev/api/".freeze

  class Spaceships
    include Mechanizable

    def get_show(url)
      response = get url

      response = JSON.parse response.body

      validate_request_contract! request

      response
    end

    def validate_request_contract!(request)
      SpaceshipsRequestContract.new.call(request)
    end
  end

  class Planets
    include Mechanizable

    def get_show(url)
      response = get url

      response = JSON.parse response.body

      validate_request_contract! request

      response
    end

    def validate_request_contract!(request)
      PlanetsRequestContract.new.call(request)
    end
  end

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

      validate_request_contract! response

      response
    end

    def validate_request_contract!(request)
      RequestContract.new.call(request)
    end
  end
end
