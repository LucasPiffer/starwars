class RequestContract < Dry::Validation::Contract
  params do
    required(:count).value(:string)
    required(:previous).value(:string)
    required(:results).value(:array)
    required(:next).value(:string)
  end
end

