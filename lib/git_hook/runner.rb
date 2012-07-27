require 'git'
require 'thor'
require 'hashr'
require 'git_hook'

module GitHook
  class Runner
    def self.run(timing)
      ctx = self.context
      result = ctx.config.hooks[timing.to_sym].inject(true) do | result, hook |
        result && hook[:class].new(ctx.repository, timing.to_sym, hook[:options] || {}).invoke
      end

      unless result
        exit(1)
      end
    end

    def self.invoke(timing, hook_name)
      ctx = self.context
      ctx.config.hooks[timing.to_sym].each do | hook |
        if hook[:class].name == hook_name
          return hook[:class].new(ctx.repository, timing.to_sym, hook[:options] || {}).invoke
        end
      end
    end

    def self.context
      dsl = GitHook::DSL.eval('.githooks')
      repository = Git.open('.')
      GitHook.io.tty = `git config --get color.ui 2> #{GitHook::NULL}`.strip == 'true' ? Thor::Shell::Color.new : Thor::Shell::Basic.new
      return Hashr.new({
        config: dsl,
        repository: repository,
        io: GitHook.io
      })
    end
  end
end
