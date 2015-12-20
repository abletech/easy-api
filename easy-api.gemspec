# -*- encoding: utf-8 -*-
require File.expand_path('../lib/easy/api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "easy-api"
  gem.version       = Easy::Api::VERSION
  gem.authors       = ["Shevaun Coker", "Joseph Leniston", "Nigel Ramsay"]
  gem.email         = ["shevaun.coker@abletech.co.nz", "joseph.leniston@abletech.co.nz", "nigel.ramsay@abletech.co.nz"]
  gem.description   = %q{Enables consistent responses for API calls}
  gem.summary       = %q{Facilitates standard success and error behaviour in API responses}
  gem.homepage      = "https://github.com/AbleTech/easy-api"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'activemodel', '>= 3.0.0'
  gem.add_development_dependency 'actionpack', '>= 3.0.0'
  gem.add_development_dependency 'activesupport', '>= 3.0.0'
  gem.add_development_dependency 'multi_json', '~> 1.0'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec', '>= 2.14'
  gem.add_development_dependency 'rspec-rails'
  gem.add_development_dependency 'guard-rspec', '~> 4.6'
end
