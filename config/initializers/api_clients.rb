RottenTomatoes::Rotten.api_key = ENV['ROTTENTOMATOES_KEY']
Tmdb::Api.key ENV['TMDB_KEY']
$places = GooglePlaces::Client.new(ENV['GOOGLE_KEY'])
$tmdb_config = Tmdb::Configuration.new.fetch_response