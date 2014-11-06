$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "lorde/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "lorde"
  s.version     = Lorde::VERSION
  s.authors     = ["Your name"]
  s.email       = ["Your email"]
  s.summary     = "Summary of Lorde."
  s.description = "Description of Lorde."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.10"

  s.add_development_dependency "sqlite3"
end
