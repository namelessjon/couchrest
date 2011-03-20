Gem::Specification.new do |s|
  s.name     = "sovaa"
  s.version  = "0.0.6"
  s.date     = "2011-03-19"
  s.summary  = "CouchDB library"
  s.email    = "jonathan.stott@gmail.com"
  s.homepage = "http://github.com/namelessjon/couchrest"
  s.has_rdoc = true
  s.authors  = ["Jonathan Stott"]
  s.files    = [
    "README.md", 
		"sovaa.gemspec", 
		"lib/sovaa.rb",
    "lib/sovaa/database.rb",
    "lib/sovaa/json_response.rb",
    "lib/sovaa/http.rb",
    "lib/sovaa/server.rb"
  ]

  s.add_dependency "httpi"
  s.add_dependency "yajl-ruby"
  s.add_development_dependency "rspec-core", "~> 2.5.1"
  s.add_development_dependency "rspec-mocks", "~> 2.5.0"
  s.add_development_dependency "rspec-expectations", "~> 2.5.0"
end

