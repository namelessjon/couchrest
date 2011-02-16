require File.expand_path("../../spec_helper", __FILE__)

describe Sova do

  before(:each) do
    @cr = Sova.new(COUCHHOST)
    begin
      @db = @cr.database(TESTDB)
      @db.delete! rescue nil      
    end
  end

  after(:each) do
    begin
      @db.delete! rescue nil
    end
  end

  describe "getting info" do
    it "should list databases" do
      @cr.databases.should be_an_instance_of(Array)
    end
    it "should get info" do
      @cr.info["couchdb"].should == "Welcome"
      @cr.info.class.should == Hash   
    end
  end
  
  it "should provide one-time access to uuids" do
    @cr.next_uuid.should_not be_nil
  end

  describe "initializing a database" do
    it "should return a db" do
      db = @cr.database(TESTDB)
      db.should be_an_instance_of(Sova::Database)
      db.host.should == @cr.uri
    end
  end

  describe "parsing urls" do
    it "should parse just a dbname" do
      db = Sova.parse "my-db"
      db[:database].should == "my-db"
      db[:host].should == "http://127.0.0.1:5984"
    end
    it "should parse a host and db" do
      db = Sova.parse "127.0.0.1/my-db"
      db[:database].should == "my-db"
      db[:host].should == "http://127.0.0.1"
    end
    it "should parse a host and db with http" do
      db = Sova.parse "http://127.0.0.1/my-db"
      db[:database].should == "my-db"
      db[:host].should == "http://127.0.0.1"
    end
    it "should parse a host and db with https" do
      db = Sova.parse "https://127.0.0.1/my-db"
      db[:database].should == "my-db"
      db[:host].should == "https://127.0.0.1"
    end
    it "should parse a host with a port and db" do
      db = Sova.parse "127.0.0.1:5555/my-db"
      db[:database].should == "my-db"
      db[:host].should == "http://127.0.0.1:5555"
    end
    it "should parse a host with a port and db with http" do
      db = Sova.parse "http://127.0.0.1:5555/my-db"
      db[:database].should == "my-db"
      db[:host].should == "http://127.0.0.1:5555"
    end
    it "should parse a host with a port and db with https" do
      db = Sova.parse "https://127.0.0.1:5555/my-db"
      db[:database].should == "my-db"
      db[:host].should == "https://127.0.0.1:5555"
    end
    it "should parse just a host" do
      db = Sova.parse "http://127.0.0.1:5555/"
      db[:database].should be_nil
      db[:host].should == "http://127.0.0.1:5555"
    end
    it "should parse just a host with https" do
      db = Sova.parse "https://127.0.0.1:5555/"
      db[:database].should be_nil
      db[:host].should == "https://127.0.0.1:5555"
    end
    it "should parse just a host no slash" do
      db = Sova.parse "http://127.0.0.1:5555"
      db[:host].should == "http://127.0.0.1:5555"
      db[:database].should be_nil
    end
    it "should parse just a host no slash and https" do
      db = Sova.parse "https://127.0.0.1:5555"
      db[:host].should == "https://127.0.0.1:5555"
      db[:database].should be_nil
    end
    it "should get docid" do
      db = Sova.parse "127.0.0.1:5555/my-db/my-doc"
      db[:database].should == "my-db"
      db[:host].should == "http://127.0.0.1:5555"
      db[:doc].should == "my-doc"
    end
    it "should get docid with http" do
      db = Sova.parse "http://127.0.0.1:5555/my-db/my-doc"
      db[:database].should == "my-db"
      db[:host].should == "http://127.0.0.1:5555"
      db[:doc].should == "my-doc"
    end
    it "should get docid with https" do
      db = Sova.parse "https://127.0.0.1:5555/my-db/my-doc"
      db[:database].should == "my-db"
      db[:host].should == "https://127.0.0.1:5555"
      db[:doc].should == "my-doc"
    end
  end

  describe "easy initializing a database adapter" do
    it "should be possible without an explicit Sova instantiation" do
      db = Sova.database "http://127.0.0.1:5984/couchrest-test"
      db.should be_an_instance_of(Sova::Database)
      db.host.should == "http://127.0.0.1:5984"
    end
    # TODO add https support (need test environment...)
    # it "should work with https" # do
    #      db = Sova.database "https://127.0.0.1:5984/couchrest-test"
    #      db.host.should == "https://127.0.0.1:5984"
    #    end
    it "should not create the database automatically" do
      db = Sova.database "http://127.0.0.1:5984/couchrest-test"
      lambda{db.info}.should raise_error(Sova::NotFound)
    end
  end

  describe "ensuring the db exists" do
    it "should be super easy" do
      db = Sova.database! "#{COUCHHOST}/couchrest-test-2"
      db.name.should == 'couchrest-test-2'
      db.info["db_name"].should == 'couchrest-test-2'
    end
  end

  describe "successfully creating a database" do
    it "should start without a database" do
      @cr.databases.should_not include(TESTDB)
    end
    it "should return the created database" do
      db = @cr.create_db(TESTDB)
      db.should be_an_instance_of(Sova::Database)
    end
    it "should create the database" do
      db = @cr.create_db(TESTDB)
      @cr.databases.should include(TESTDB)
    end
  end

  describe "failing to create a database because the name is taken" do
    before(:each) do
      db = @cr.create_db(TESTDB)
    end
    it "should start with the test database" do
      @cr.databases.should include(TESTDB)
    end
    it "should PUT the database and raise an error" do
      lambda{
        @cr.create_db(TESTDB)
      }.should raise_error(Sova::HTTPError)
    end
  end
end
