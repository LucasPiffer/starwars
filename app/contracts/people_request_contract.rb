class PeopleRequestContract < Dry::Validation::Contract
  params do
    required(:count).filled(:string)
    required(:previous).filled(:string)
    required(:results).filled(:array)
    required(:next).value(:integer)
  end
end

