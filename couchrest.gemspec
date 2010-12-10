Gem::Specification.new do |s|
  s.name = "couchrest"
  s.version = "1.0.1"

  s.authors = ["J. Chris Anderson", "Matt Aimonetti", "Marcos Tapajos", "Will Leinweber", "Sam Lown"]
  s.date = "2010-08-21"
  s.description = "CouchRest provides a simple interface on top of CouchDB's RESTful HTTP API, as well as including some utility scripts for managing views and attachments."
  s.email = "jchris@apache.org"
  s.homepage = "http://github.com/couchrest/couchrest"
  s.require_paths = ["lib"]
  s.summary = "Lean and RESTful interface to CouchDB."

  s.add_dependency("json", "~> 1.4.6")
  s.add_dependency("httpi", "~> 0.7.3")

  s.add_development_dependency("rspec", "~> 2.2.0")
end                

