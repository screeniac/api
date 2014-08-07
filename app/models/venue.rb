class Venue < ActiveRecord::Base
  has_many :events
  has_many :shows, through: :events
  
  def self.find_or_create_by_query(query, attributes = {})
    spot = $places.spots_by_query(query, types: ['movie_theater']).first
    
    return existing if existing = Venue.find_by_place_id(spot.place_id)
    
    venue = Venue.new.assign_from_spot($places.spot(spot.place_id))
    venue.attributes = attributes
    venue.save!
    venue
  end
  
  def assign_from_spot(spot)
    self.name = spot.name
    self.lat = spot.lat
    self.lng = spot.lng
    self.address = spot.formatted_address.split(',').first
    self.city = spot.city
    self.state = spot.region
    self.zipcode = spot.postal_code
    self.places_url = spot.url
    self.url = spot.website
    self
  end
end