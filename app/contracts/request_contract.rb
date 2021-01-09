class RequestContract < Dry::Validation::Contract
  params do
    required(:count).value(:integer)
    required(:results).value(:array)
    required(:next).maybe(:string)
  end
end

