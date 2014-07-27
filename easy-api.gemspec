# -*- encoding: utf-8 -*-
require File.expand_path('../lib/easy/api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "easy-api"
  gem.version       = Easy::Api::VERSION
  gem.authors       = ["Shevaun Coker", "Joseph Leniston"]
  gem.email         = ["shevaun.coker@abletech.co.nz", "joseph.leniston@abletech.co.nz"]
  gem.description   = %q{A repository of common, reusable API code}
  gem.summary       = %q{Provides consistent responses for Abletech APIs}
  gem.homepage      = "https://github.com/AbleTech/easy-api"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'activemodel', '>= 3.0.0'
  gem.add_development_dependency 'actionpack', '>= 3.0.0'
  gem.add_development_dependency 'activesupport', '>= 3.0.0'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec', '~> 2.14'
  gem.add_development_dependency 'rspec-rails'
end
