class Show < ActiveRecord::Base
  has_many :events
  has_many :venues, through: :events
  
  def self.find_or_create_by_query(title)
    return existing if existing = where('title LIKE ?', title).first
    
    show = Show.new
    
    if rt = RottenTomatoes::RottenMovie.find(title: title, limit: 1)
      return existing if existing = where('rt_id = ? OR imdb_id = ?', rt.id, rt.alternate_ids.try(:imdb)).first
      show.assign_from_rotten_tomatoes(rt)
    end
    
    if tmdb = Tmdb::Movie.find(title).try(:first)
      return existing if existing = where(tmdb_id: tmdb.id).first
      tmdb = Tmdb::Movie.detail(tmdb.id)
      show.assign_from_tmdb(tmdb)
    end
    
    if !rt && !tmdb
      find_or_create_by_query title.split(':').first.strip
    end
    
    show.save!
    show
  end
  
  def assign_from_rotten_tomatoes(data)
    self.rt_id = data.id
    self.imdb_id = data.alternate_ids.try(:imdb)
    self.title = data.title
    self.tomato_score = data.ratings.critics_score
    self.audience_score = data.ratings.audience_score
    self.release_date = data.release_dates.theater
    self.runtime = data.runtime
    self.rating = data.mpaa_rating
  end
  
  def assign_from_tmdb(data)
    self.tmdb_id = data.id
    self.imdb_id = data.imdb_id
    self.summary = data.overview
    self.tagline = data.tagline
    self.poster_url = [$tmdb_config['images']['secure_base_url'] + 'w500/' + data.poster_path].join('/')
    self.backdrop_url = [$tmdb_config['images']['secure_base_url'] + 'w780/' + data.poster_path].join('/')
    
    self.title ||= data.title
    self.release_date ||= data.release_date
  end
end