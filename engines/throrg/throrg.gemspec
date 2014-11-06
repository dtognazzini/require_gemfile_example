$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "throrg/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "throrg"
  s.version     = Throrg::VERSION
  s.authors     = ["Your name"]
  s.email       = ["Your email"]
  s.summary     = "Summary of Throrg."
  s.description = "Description of Throrg."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.10"

  s.add_development_dependency "sqlite3"
end
