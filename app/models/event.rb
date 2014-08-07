class Event < ActiveRecord::Base
  include Grape::Entity::DSL
  
  belongs_to :show
  belongs_to :venue
  
  validates_uniqueness_of :time, scope: [:show_id, :venue_id]
  
  def self.upcoming
    where("events.time > ?", Time.now).order(:time)
  end
  
  entity do
    expose :id
    expose :show, using: Show::Entity
    expose :venue, using: Venue::Entity
    expose :time
    expose :url, :ticket_url 
  end
end