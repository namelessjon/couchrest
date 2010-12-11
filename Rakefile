$LOAD_PATH.unshift "lib"
require 'rake'
require "rake/rdoctask"
require 'rspec/core/rake_task'

desc "Run all specs"
RSpec::Core::RakeTask.new('spec') do |t|
	t.rspec_opts = ["--color"]
	t.pattern = 'spec/**/*_spec.rb'
end

desc "Print specdocs"
RSpec::Core::RakeTask.new(:doc) do |t|
	t.rspec_opts = ["--format", "specdoc"]
	t.pattern = 'spec/*_spec.rb'
end

desc "Generate the rdoc"
Rake::RDocTask.new do |rdoc|
  files = ["README.rdoc", "LICENSE", "lib/**/*.rb"]
  rdoc.rdoc_files.add(files)
  rdoc.main = "README.rdoc"
  rdoc.title = "CouchRest: Ruby CouchDB, close to the metal"
end

desc "Run the rspec"
task :default => :spec
