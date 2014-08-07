class Show < ActiveRecord::Base
  include Grape::Entity::DSL
  
  has_many :events
  has_many :venues, through: :events
  
  def self.find_or_create_by_query(title)
    existing = where('title LIKE ?', title).first
    return existing if existing
    
    show = Show.new
    
    if rt = Array(RottenTomatoes::RottenMovie.find(title: title, limit: 1)).first
      existing = where('rt_id = ? OR imdb_id = ?', rt.id, rt.alternate_ids.try(:imdb)).first
      return existing if existing
      
      show.assign_from_rotten_tomatoes(rt)
    end
    
    if tmdb = Tmdb::Movie.find(title).try(:first)
      existing = where(tmdb_id: tmdb.id.to_s).first
      return existing if existing
      
      tmdb = Tmdb::Movie.detail(tmdb.id.to_s)
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
    self.tmdb_id = data.id.to_s
    self.imdb_id = data.imdb_id
    self.summary = data.overview
    self.tagline = data.tagline
    self.poster_url = '//image.tmdb.org/t/p/w500' + data.poster_path if data.poster_path
    self.backdrop_url = '//image.tmdb.org/t/p/w780' + data.backdrop_path if data.backdrop_path
    
    self.title ||= data.title
    self.release_date ||= data.release_date
  end
  
  def year
    release_date.year
  end
  
  entity do
    expose :id, :title, :year, :release_date, :runtime, :rating, :summary, :tagline
    
    expose(:images){|show| {poster: show.poster_url, backdrop: show.backdrop_url} }
    expose(:scores){|show| {rotten_tomatoes: show.tomato_score, audience: show.audience_score} } 
    expose(:external_ids){|show| {imdb: show.imdb_id, rotten_tomatoes: show.rt_id, tmdb: show.tmdb_id} }
  end
end