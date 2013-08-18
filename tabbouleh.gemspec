$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tabbouleh/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tabbouleh"
  s.version     = Tabbouleh::VERSION
  s.authors     = ["Johannes Badursson"]
  s.email       = ["johannes.baldursson@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Tabbouleh."
  s.description = "TODO: Description of Tabbouleh."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"
  s.add_dependency "parsley-rails", "~> 1.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "jquery-rails"
end
