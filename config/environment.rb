require 'bundler'

#will load all of my gems
Bundler.require

#bcause u use (open(index_url) in room_scraper class  
require 'open-uri'

#enviroment is responsible to get the database loaded 
DB = {
    :connection => SQLite3::Database.new("db/rooms-development.sqlite")
}

require_all 'lib'