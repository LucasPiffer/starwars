class PeopleBuilder
  def self.build(people)
    people.each do |people_structure|
      validate_people_contract! people_structure

      People.create(people_structure)
    rescue => e
      Rails.logger.info "Failed to..."
    end
  end

  def self.validate_people_contract!(people)
    PeopleContract.new.call(people)
  end
end
