class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :place_id
      t.string :name
      t.float :lat
      t.float :lng
      t.string :address
      t.string :city
      t.string :state, limit: 2
      t.string :zipcode
      t.string :places_url
      t.string :url
      t.string :scraper_ref
      
      t.timestamps
    end
  end
end
