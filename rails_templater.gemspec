# -*- encoding: utf-8 -*-
require File.expand_path("../lib/rails_templater/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rails_templater"
  s.version     = RailsTemplater::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Kevin Faustino"]
  s.email       = ["kevin.faustino@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/rails_templater"
  s.summary     = "Template generator for Ruby on Rails 3.1 applications"
  s.description = "Template generator for Ruby on Rails 3.1 applications"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path = 'lib'

  s.required_rubygems_version = ">= 1.3.6"

  # Run-time dependencies
  s.add_dependency "rails", "~> 3.1"

  # Rspec
  s.add_development_dependency "rspec"
  s.add_development_dependency "faker"
  s.add_development_dependency "factory_girl"
  s.add_development_dependency 'mocha'

  # Guard
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-bundler'
  s.add_development_dependency 'guard-rspec'
end
