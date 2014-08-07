workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['MIN_THREADS']  || 1), Integer(ENV['MAX_THREADS'] || 16)

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # worker specific setup
  ActiveSupport.on_load(:active_record) do
    db_config = YAML.load_file('./db/config.yml')[ENV['RACK_ENV']] rescue nil
    db_config['pool'] = ENV['MAX_THREADS'] || 16
    ActiveRecord::Base.establish_connection(db_config)
  end
end