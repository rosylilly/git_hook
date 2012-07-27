require 'git'
require 'thor'
require 'git_hook'

module GitHook
  class Runner
    def self.run(timing)
      context = GitHook::DSL.eval('.githooks')
      repository = Git.open('.')
      GitHook.io.tty = `git config --get color.ui 2> #{GitHook::NULL}`.strip == 'true' ? Thor::Shell::Color.new : Thor::Shell::Basic.new
      result = context.hooks[timing.to_sym].inject(true) do | result, hook |
        result && hook[:class].new(repository, timing.to_sym, hook[:options] || {}).invoke
      end

      unless result
        exit(1)
      end
    end
  end
end
