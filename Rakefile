task :environment do
  require_relative './config/environment'
end

namespace :scrape do
  task :all => [:arclight, :nuart]
  
  task :arclight => :environment do
    puts
    puts "==== SCRAPING ARCLIGHT THEATER SITE"
    Scrapers::Arclight.new.perform
  end
  
  task :nuart => :environment do
    puts
    puts "==== SCRAPING NUART THEATER SITE"
    Scrapers::Nuart.new.perform
  end
end

require 'active_record_migrations'
ActiveRecordMigrations.configure do |c|
  if ENV['DATABASE_URL']
    c.database_configuration = {ENV['RACK_ENV'] => ENV['DATABASE_URL']}
  else
    c.yaml_config = 'config/database.yml'
  end
end

ActiveRecordMigrations.load_tasks