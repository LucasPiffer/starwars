class StarcraftContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:model).filled(:string)
    required(:url).filled(:string)
  end
end

