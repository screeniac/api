require 'bundler'
ENV['RACK_ENV'] ||= 'development'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require 'dotenv'
Dotenv.load

APP_ROOT = File.expand_path(File.dirname(__FILE__) + "/../")

$:.push APP_ROOT

Dir[File.dirname(__FILE__) + "/initializers/*.rb"].each do |initializer|
  puts "Loading #{initializer}..."
  load initializer
end

require 'yaml'
db_config = YAML.load_file('./config/database.yml')[ENV['RACK_ENV']] rescue nil
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || db_config)

require 'app/api'

require 'app/models/show'
require 'app/models/venue'
require 'app/models/event'

require 'app/scrapers/arclight'
require 'app/scrapers/nuart'