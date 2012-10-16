$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "spud_inquiries/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "spud_inquiries"
  s.version     = Spud::Inquiries::VERSION
  s.authors     = ["David Estes"]
  s.email       = ["destes@redwindsw.com"]
  s.homepage    = "http://www.github.com/davydotcom/spud_inquiries"
  s.summary     = "Inquiry form builder and mailer for spud (Useful for Contact Forms)."
  s.description = "This gem allows you to build forms for user submission and can send email notifications when a form is filled out."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.markdown"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.2"
  s.add_dependency 'spud_core', ">= 0.9.0","< 1.0.0"

  s.add_development_dependency "mysql2"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency 'factory_girl', '2.5.0'
  s.add_development_dependency 'mocha', '0.10.3'
  s.add_development_dependency "database_cleaner", "0.7.1"
end
