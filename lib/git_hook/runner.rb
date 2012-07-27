require 'git'
require 'git_hook'

module GitHook
  class Runner
    def run(timing)
      context = GitHook::DSL.eval('.githooks')
      repository = Git.open('.')
      result = context.hooks[timing.to_sym].inject(true) do | result, hook |
        result && hook[:class].new(repository, timing.to_sym, hook[:options] || {}).invoke
      end

      unless result
        exit(1)
      end
    end
  end
end
