$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spud_inquiries/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spud_inquiries"
  s.version     = Spud::Inquiries::VERSION
  s.authors     = ["David Estes"]
  s.email       = ["destes@redwindsw.com"]
  s.homepage    = "http://www.github.com/spud-rails/spud_inquiries"
  s.summary     = "Inquiry form builder and mailer for spud (Useful for Contact Forms)."
  s.description = "This gem allows you to build forms for user submission and can send email notifications when a form is filled out."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", ">= 4.0.0"
  s.add_dependency 'spud_core', "~> 1.0.0"
  s.add_dependency 'liquid'

  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rspec', '2.14.0'
  s.add_development_dependency 'rspec-rails', '2.14.0'
  s.add_development_dependency 'shoulda', '~> 3.0.1'
  s.add_development_dependency 'factory_girl', '~> 3.0'
  s.add_development_dependency 'database_cleaner', '1.0.0.RC1'
  s.add_development_dependency 'mocha', '0.14.0'
  s.add_development_dependency 'simplecov', '~> 0.6.4'
end
