task :environment do
  require_relative './config/environment'
end

require 'active_record_migrations'
ActiveRecordMigrations.configure do |c|
  c.yaml_config = 'config/database.yml'
end

ActiveRecordMigrations.load_tasks