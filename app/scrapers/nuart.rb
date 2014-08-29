require 'nokogiri'
require 'open-uri'

module Scrapers
  class Nuart
    def perform
      date = Date.today.friday?? Date.today : Chronic.parse('friday').to_date
      while true
        doc = load_date(date)
        ticket_link = doc.search("a[text()='11:59']").first
        unless ticket_link
          "*** No showtimes found for #{date}"
          break
        end
        
        title = ticket_link.parent.parent.previous_element.search('.TSShowtimeMovie a').text
        show = Show.find_or_create_by_query(title)
        
        event = Event.new(
          venue: venue,
          show: show,
          time: ActiveSupport::TimeZone.new('US/Pacific').local_to_utc(Chronic.parse(date.to_s + " at 11:59pm")),
          ticket_url: "https://tickets.landmarktheatres.com/#{ticket_link[:href]}"
        )
        if event.save
          puts "- Added screening for #{show.title} at #{venue.name} (#{venue.city}) - #{event.time.in_time_zone('US/Pacific')}"
        else
          puts "- NOT SAVED: \"#{show.title}\" (#{event.errors.full_messages.join(", ")})"
        end
        
        date += 7
      end
    end
    
    def load_date(date)
      Nokogiri::HTML(open("https://tickets.landmarktheatres.com/(S(vbtzor3nzfs32n1wuuldpb2m))/Ticketing.aspx?ShowDate=#{date.strftime('%m/%d/%Y')}&TheatreID=209").read)
    end
    
    def venue
      @venue ||= Venue.find_by_scraper_ref('209')
    end
  end
end