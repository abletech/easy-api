# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy/api/version'

Gem::Specification.new do |gem|
  gem.name          = "easy-api"
  gem.version       = Easy::Api::VERSION
  gem.authors       = ["Shevaun Coker"]
  gem.email         = ["shevaun.coker@abletech.co.nz"]
  gem.description   = %q{A repository of common, reusable API code}
  gem.summary       = %q{Provides consistent responses for Abletech APIs}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'rails', '>= 3.0.0'

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rspec', '~> 2.0'
end
