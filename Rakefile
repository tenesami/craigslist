require_relative './config/environment.rb'

def reload!
    load_all './lib'
end

task :console do
Pry.start
end

#
task :scrape_rooms do
    #instantiate scraper, and then have it find new rooms
    #nyc_scraper = RoomScraper.new('https://newyork.craigslist.org/search/roo')
    denver_scraper = RoomScraper.new('https://denver.craigslist.org/search/roo')
    denver_scraper.call
    #after this method call, I should be able to say Room.all and have rooms there
end