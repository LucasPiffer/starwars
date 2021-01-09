module ActAsPresentable
  def presentation
    "Olá! Meu nome é #{name}. #{presentation_species}, meu peso"\
    " #{presentation_weight}, nasci em #{presentation_homeworld} #{presentation_year}"\
    " e #{presentation_starcrafts}”"
  end

  def presentation_species
    size = species.size

    if size == 0
      'Não possuo uma espécie identificada'
    elsif size == 1
      "Sou um #{species.first.name}"
    else
      str = "Sou uma mistura de "

      last = species.last.name
      str = "#{str} #{species[0..-2].map { |species_record| species_record.name }.join('com ')}"

      "#{str} e #{last}"
    end
  end

  def presentation_weight
    "é #{mass}Kg"
  end

  def presentation_homeworld
    planet.name
  end

  def presentation_year
    if birth_year == 'unknown'
      'em algum ano desconhecido'
    else
      "no ano #{birth_year}"
    end
  end

  def presentation_starcrafts
    size = starcrafts.size

    if size == 0
      "nunca estive em uma nave"
    elsif size == 1
      "já estive na #{starcrafts.first.name}"
    else
      last = starcrafts[-1]
      str = starcrafts[0..-2].map { |record| record.name }.join(', ')

      "já estive nas seguintes naves #{str} e #{last.name}"
    end
  end
end
