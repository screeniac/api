task :environment do
  require_relative './config/environment'
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