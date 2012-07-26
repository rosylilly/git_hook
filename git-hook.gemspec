# -*- encoding: utf-8 -*-
require File.expand_path('../lib/git-hook/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sho Kusano"]
  gem.email         = ["rosylilly@aduca.org"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "git-hook"
  gem.require_paths = ["lib"]
  gem.version       = GitHook::VERSION

  gem.add_dependency "thor", "0.15.4"
end
