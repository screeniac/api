require 'nokogiri'
require 'open-uri'
require 'active_support/core_ext'

module Scrapers
  class Arclight
    def perform
      movies = []
      
      html = open('https://www.arclightcinemas.com/en/locations/los-angeles/showtimes/?ItemId=%7B4D3EE2D0-2337-4C56-A103-B5CA6FB924D9%7D').read
      doc = Nokogiri::HTML(html)      
      
      doc.search('.location-block').each do |listing|
        movie = {
          title: listing.search('h2.showing-locationh2 > a').text.gsub(/ArcLight Presents\.\.\./i,'').gsub(/AL Presents\:/i,'').strip.downcase,
          image: listing.search('img').first['src']
        }
        
        
        movie[:screenings] = listing.search('.cached-seat-hover').map do |ticket_link|
          time = ActiveSupport::TimeZone.new('US/Pacific').local_to_utc(Chronic.parse(ticket_link['title']))
          
          {
            scraper_ref: ticket_link['data-locationid'],
            url: listing.search('.see-more-details-showtime a').first['href'],
            ticket_url: ticket_link['href'],
            time: time
          }
        end
        
        movies << movie
      end
      
      movies.each do |data|
        show = Show.find_or_create_by_query(data[:title])
        data[:screenings].each do |info|
          venue = Venue.find_by_scraper_ref info[:scraper_ref]
          event = Event.new(venue: venue, show: show, time: info[:time], url: info[:url], ticket_url: info[:ticket_url])
          
          if event.save
            puts "- Added screening for #{show.title} at #{venue.name} (#{venue.city}) - #{event.time.in_time_zone('US/Pacific')}"
          else
            puts "- NOT SAVED: \"#{show.title}\" (#{event.errors.full_messages.join(", ")})"
          end
        end
      end
    end
  end
end