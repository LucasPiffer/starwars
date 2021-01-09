json.people do
  json.id @person.id
  json.name @person.name
  json.external_url @person.url
  json.planet do
    json.id @person.planet&.id
    json.name @person.planet&.name
    json.external_url @person.planet&.url
  end
  json.species @person.species do |species|
    json.id species.id
    json.name species.name
    json.external_url species.url
  end
  json.starcrafts @person.starcrafts do |starcraft|
    json.id starcraft.id
    json.name starcraft.name
    json.model starcraft.model
    json.external_url starcraft.url
  end
  json.presentation @person.presentation
end