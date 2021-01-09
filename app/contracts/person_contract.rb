class PersonContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:homeworld).filled(:string)
    required(:species).filled(:array)
    required(:starships).filled(:array)
  end
end


