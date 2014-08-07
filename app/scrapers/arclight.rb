require 'nokogiri'
require 'open-uri'

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
          {
            location: ticket_link['data-locationid'],
            url: listing.search('.see-more-details-showtime a').first['href'],
            ticket_url: ticket_link['href'],
            time: ticket_link['title']
          }
        end
        
        movies << movie
      end
      
      movies.each{|s| puts s.inspect}
    end
  end
end