# -*- encoding: utf-8 -*-
require File.expand_path('../lib/auto_tagging/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Eastagile"]
  gem.email         = ["admin@eastagile.com"]
  gem.description   = %q{A ruby wrapper library for all current top tags/keywords/terms extraction services , this version 
                        supports Alchemy, Yahoo Content Analysis, Delicious V1 API and OpenCalais }
  gem.summary       = %q{Supports tags extraction for both text and url ,just simply call AutoTagging.get_tags(url: "http://google.com")
                        or AutoTagging.get_tags("Neque porro quisquam est qui dolorem ipsum quia dolor sit amet")}
  gem.homepage      = "http://www.eastagile.com"

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
