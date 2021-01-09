desc "Rake task to populate DB with initial data"
task :populate_db => :environment do
  SpeciesService.save_all
  StarcraftsService.save_all
  PlanetsService.save_all

  PeopleService.save_all
end