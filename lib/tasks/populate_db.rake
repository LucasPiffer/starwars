desc "Rake task to populate DB with initial data"
task :populate_db => :environment do
  PeopleService.save_all
end