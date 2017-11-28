require File.expand_path("../lib/batch_notifier/version", __FILE__)

Gem::Specification.new do |s|
  s.name          = "batch_notifier"
  s.version       = BatchNotifier::VERSION
  s.platform      = Gem::Platform::RUBY

  s.summary       = "Ruby bindings for the Batch API"
  s.description   = "Ruby bindings for the Batch API."
  s.authors       = ["Thibault Dalban"]
  s.email         = ["dahu@alpine-lab.com"]
  s.homepage      = "http://github.com/alpine-lab/batch_notifier"
  s.license       = "MIT"

  s.files         = Dir["{lib}/**/*.rb"]
  s.test_files    = Dir["spec/**/*.rb"]
  s.require_path  = "lib"
end
