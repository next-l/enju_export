$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "enju_export/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "enju_export"
  s.version     = EnjuExport::VERSION
  s.authors     = ["Kosuke Tanabe"]
  s.email       = ["tanabe@mwr.mediacom.keio.ac.jp"]
  s.homepage    = "https://github.com/next-l/enju_export"
  s.summary     = "enju_export plugin"
  s.description = "Exporting records of Next-L Enju"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "state_machine"
  s.add_dependency "paperclip"
  s.add_dependency "simple_form"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
