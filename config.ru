require_relative './config/environment'
require 'app/api'

use Rack::Cors do
  allow do
    origins ENV['WEB_ORIGIN'] || '*'
    resource '*', headers: :any, methods: [:get]
  end
end

run API