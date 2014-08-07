class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :imdb_id
      t.string :tmdb_id
      t.string :rt_id
      
      t.string :title
      t.string :rating, limit: 20
      t.date :release_date
      t.integer :runtime
      t.text :summary
      t.text :tagline
      
      t.string :poster_url
      t.string :backdrop_url
      
      t.integer :tomato_score
      t.integer :audience_score
      
      t.timestamps
    end
  end
end
