$LOAD_PATH.unshift "lib"
require "rspec/core"
require "sova"

#$LOAD_PATH.unshift "../rocking_chair/lib"
#require "rocking_chair"

#Sovaa::HTTP.adapter = :rocking_chair

HTTPI.log = false

unless defined?(FIXTURE_PATH)
  FIXTURE_PATH = File.join(File.dirname(__FILE__), '/fixtures')
  SCRATCH_PATH = File.join(File.dirname(__FILE__), '/tmp')

  COUCHHOST = ENV['COUCHHOST'] || "http://127.0.0.1:5984"
  TESTDB    = 'couchrest-test'
  REPLICATIONDB = 'couchrest-test-replication'
  TEST_SERVER    = Sovaa.new COUCHHOST
  DB = TEST_SERVER.database(TESTDB)
end
