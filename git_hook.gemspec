# -*- encoding: utf-8 -*-
require File.expand_path('../lib/git_hook/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sho Kusano"]
  gem.email         = ["rosylilly@aduca.org"]
  gem.description   = %q{git hooks management command line tool}
  gem.summary       = %q{git hooks management command line tool}
  gem.homepage      = "https://github.com/rosylilly/git_hook"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "git_hook"
  gem.require_paths = ["lib"]
  gem.version       = GitHook::VERSION

  gem.add_dependency "thor", "0.15.4"
  gem.add_dependency "hashr", "0.0.21"
  gem.add_dependency "git", "1.2.5"
end
