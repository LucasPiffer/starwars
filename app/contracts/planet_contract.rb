class PlanetContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:url).filled(:string)
  end
end


