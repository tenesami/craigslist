class Room 
    attr_accessor :id, :title, :date_created, :price, :url

    def self.create_from_hash(hash) #instantiating and save
        new_from_hash(hash).save
    end

    def self.new_from_hash(hash) #just instantiating
        room = self.new
        room.title = hash[:title]
        room.date_created = hash [:date_created]
        room.price = hash[:price]
        room.url = hash[:url]
        
        room #dangling return value mean instanitate and return the value 
    end

    def self.by_price(order = "ASC")
        
        sql <<-SQL
        SELECT * FROM rooms ORDER BY price #{order}
        SQL
        rows = DB[:connection].execute(sql)
        self.new_from_rows(rows)

        # case order
        # when "ASC"
        #     self.all.sort_by{|r| r.price}
        # when "DESC"
        #     self.all.sort_by{|r| r.price}.reverse
        # end

    end

    #Room.by_price("ASC") #=> lowest price room first
    #Room.by_price("DESC") #=> highest price room first

    def self.new_from_rows(rows)
        rows.collect do |row|
        self.new_from_db(row)
        end
    end

    def self.new_from_db(row)
        self.new.tap do |room| #tap do the entire block or expression retur it self i.e self.new
            room.id = row[0]
            room.title = row[1]
            room.date_created = row[2]
            room.price = row[3]
            room.url = row[4]
        end
    end

    def save
        insert  
    end

    def self.all
        sql = <<-SQL
        SELECT * FROM rooms;
        SQL
        
        rows = DB[:connection].execute(sql)
        self.new_from_rows(rows)
        # #binding.pry #reify mean increase the abstraction lavel 
        # # i.e go from a row [1, "title", date, url] to an instance#<Room>
         #rows.collect do |row| # return all the instances 
          #   self.new_from_db(row) # take the data out of the database send back to 
        # end                       #to the class new_from_db(row) pass in individual row
    end

    def insert
        #I need a database
        sql = <<-SQL
        INSERT INTO rooms (title, date_created, price, url) VALUES (?, ?, ?, ?)
        SQL
        DB[:connection].execute(sql, self.title, self.date_created, self.price, self.url)
        
    end

    def self.create_table
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS rooms (
            id INTEGER PRIMARY KEY,
            title TEXT,
            date_created DATETIME,
            price TEXT,
            url TEXT
        )
        SQL
        DB[:connection].execute(sql)
    end
end