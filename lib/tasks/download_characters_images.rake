desc "Downloads images for characters"
task :download_characters_images => :environment do
  Person.all.each do |person|
    id = person.url.match(/people\/(\d+)/)[1]

    url = "https://starwars-visualguide.com/assets/img/characters/#{id}.jpg"

    open("/Users/lucaspiffer/nextwalk/starwars/app/assets/images/#{id}.jpg", 'wb') do |file|
      file << open(url).read
    end
  end
end