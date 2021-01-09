person = Person.create(name: "Darth", url: "http://xyz.com")
starcraft = Starcraft.create(name: "Xyz", model: "XXX")
planet = Planet.create(name: "xyz")
species = Species.create(name: "Human")

person.starcrafts << starcraft
person.update(planet: planet)
person.species << species
