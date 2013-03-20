# -*- encoding: utf-8 -*-
require File.expand_path('../lib/auto_tagging/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Eastagile"]
  gem.email         = ["tien.nguyen@eastagile.com"]
  gem.description   = %q{Write a gem description}
  gem.summary       = %q{Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "auto_tagging"
  gem.require_paths = ["lib"]
  gem.version       = AutoTagging::VERSION
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'debugger'
  gem.add_dependency 'alchemy-api-rb'
end
