module Sovaa
  class Server
    attr_accessor :uri, :uuid_batch_count, :available_databases
    def initialize(server = 'http://127.0.0.1:5984', uuid_batch_count = 1000)
      @uri = server
      @uuid_batch_count = uuid_batch_count
    end
  
    # Lists all databases on the server
    def databases
      HTTP.get "#{@uri}/_all_dbs"
    end
  
    # Returns a Sovaa::Database for the given name
    def database(name)
      Sovaa::Database.new(self, name)
    end
  
    # Creates the database if it doesn't exist
    def database!(name)
      create_db(name) rescue nil
      database(name)
    end
  
    # GET the welcome message
    def info
      HTTP.get "#{@uri}/"
    end

    # Create a database
    def create_db(name)
      HTTP.put "#{@uri}/#{name}"
      database(name)
    end

    # Restart the CouchDB instance
    def restart!
      HTTP.post "#{@uri}/_restart"
    end

    # Retrive an unused UUID from CouchDB. Server instances manage caching a list of unused UUIDs.
    def next_uuid(count = @uuid_batch_count)
      @uuids ||= []
      if @uuids.empty?
        @uuids = HTTP.get("#{@uri}/_uuids?count=#{count}")["uuids"]
      end
      @uuids.pop
    end
  end
end
