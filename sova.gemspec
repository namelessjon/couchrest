Gem::Specification.new do |s|
  s.name     = "sovaa"
  s.version  = "0.0.1"
  s.date     = "2011-02-17"
  s.summary  = "CouchDB library"
  s.email    = "jonathan.stott@gmail.com"
  s.homepage = "http://github.com/namelessjon/couchrest"
  s.has_rdoc = true
  s.authors  = ["Jonathan Stott"]
  s.files    = [
    "README.md", 
		"sova.gemspec", 
		"lib/sova.rb",
    "lib/sova/database.rb",
    "lib/sova/json_response.rb",
    "lib/sova/http.rb",
    "lib/sova/server.rb"
  ]

  s.add_dependency "httpi", "~> 0.8"
  s.add_dependency "yajl-ruby"
  s.add_development_dependency "rspec-core", "~> 2.5.1"
  s.add_development_dependency "rspec-mocks", "~> 2.5.0"
  s.add_development_dependency "rspec-expectations", "~> 2.5.0"
end

