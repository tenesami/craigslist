class RoomScraper

    def initialize(index_url)
        @index_url = index_url
        #when instantiate the object it basically prome's to get
        #ready to scrape open index_url
        @doc = Nokogiri::HTML(open(index_url))
        
    end


    def call
         #take each row take row_doc
        rows.each do |row_doc|
        #and then scrape_row and get that back which is found down the method
        # scrape_row(row) and pass that hash to this method create from hash and that 
        #instanciate room and put the room in the database
        Room.create_from_hash(scrape_row(row_doc)) #=> Should put the room in my database
        
        end
    end


    private
    def rows
        #if @row does not exit we use the @doc.search("div.content span.row p.row") 
        #expression 
        @rows ||= @doc.search("div.content ul.rows li.result-row")
    end

    def scrape_row(row)
        #scrape an individual row
        {
            :date_created => row.search("time.result-date").attribute("datetime").text,
            :title => row.search("a.result-title.hdrlnk").text,
            :url => "#{@index_url}#{row.search("a.result-title.hdrlnk").attribute("href").text}",
            :price => row.search("span.result-price").text,
        }
       
    end
end


