task :environment do
  require_relative './config/environment'
end

namespace :scrape do
  task :all => [:arclight]
  
  task :arclight => :environment do
    Scrapers::Arclight.new.perform
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