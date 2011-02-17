Gem::Specification.new do |s|
  s.name     = "sova"
  s.version  = "0.0.2"
  s.date     = "2011-02-17"
  s.summary  = "CouchDB library"
  s.email    = "harry@vangberg.name"
  s.homepage = "http://github.com/ichverstehe/sova"
  s.has_rdoc = true
  s.authors  = ["Harry Vangberg"]
  s.files    = [
    "README.md", 
		"sova.gemspec", 
		"lib/sova.rb",
    "lib/sova/database.rb",
    "lib/sova/http.rb",
    "lib/sova/server.rb"
  ]

  s.add_dependency "httpi", "~> 0.7.9"
  s.add_development_dependency "rspec-core", "~> 2.5.1"
  s.add_development_dependency "rspec-mocks", "~> 2.5.0"
  s.add_development_dependency "rspec-expectations", "~> 2.5.0"
end

