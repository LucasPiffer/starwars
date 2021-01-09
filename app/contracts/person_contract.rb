class PersonContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:homeworld).filled(:string)
  end
end


