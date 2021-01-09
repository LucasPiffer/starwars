class PersonContract < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:homeworld).filled(:string)
    required(:species).maybe(:array)
    required(:starships).maybe(:array)
  end
end


