$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "kami_kakushi/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "kami_kakushi"
  s.version     = KamiKakushi::VERSION
  s.authors     = ["ppworks"]
  s.email       = ["koshikawa.naoto@moneyforward.co.jp"]
  s.homepage    = "http://corp.moneyforward.com/"
  s.summary     = "Hide away record as soft delete"
  s.description = "Hide away record as soft delete"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.9"
  s.add_development_dependency "sqlite3"
end
