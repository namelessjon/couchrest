$LOAD_PATH.unshift "lib"
$LOAD_PATH.unshift "../rocking_chair/lib"
require "rspec"
require "couchrest"
require "rocking_chair"

CouchRest::HTTP.adapter = :rocking_chair

unless defined?(FIXTURE_PATH)
  FIXTURE_PATH = File.join(File.dirname(__FILE__), '/fixtures')
  SCRATCH_PATH = File.join(File.dirname(__FILE__), '/tmp')

  COUCHHOST = ENV['COUCHHOST'] || "http://127.0.0.1:5984"
  TESTDB    = 'couchrest-test'
  REPLICATIONDB = 'couchrest-test-replication'
  TEST_SERVER    = CouchRest.new COUCHHOST
  DB = TEST_SERVER.database(TESTDB)
end
