require 'thor'
require 'git_hook'
require 'git_hook/runner'

module GitHook
  class CLI < Thor
    include Thor::Actions

    class_option 'no-color', type: :boolean, desc: 'Disable color output'
    class_option 'verbose', type: :boolean, desc: 'Verbose output'

    def initialize(*args)
      super(*args)
      GitHook.io.tty = (options['no-color'] ? Thor::Shell::BasicShell.new : shell)
      GitHook.io.verbose!(true) if options['verbose']
      Dir.chdir(GitHook.repo_dir)
    end

    desc "version", "display git-hook's version"
    def version
      GitHook.io.info("git-hook version #{GitHook::VERSION}")
    end
    map %w(-v --version) => :version

    def self.source_root
      Pathname.new(File.dirname(__FILE__)).join('template').to_s
    end

    desc "install", "install git hooks"
    def install
      opts = {
        with_bundler: File.exist?('Gemfile')
      }
      unless File.exist?('.githooks')
        template('githooks.tt', '.githooks', opts)
      end

      invoke(:apply)
    end

    desc "apply", "apply git hook execute file in .git/hooks/*"
    def apply
      opts = {
        with_bundler: File.exist?('Gemfile')
      }
      config.hooks.keys.each do | timing |
        opts[:timing] = timing
        template('hook.tt', ".git/hooks/#{timing}", opts)
        chmod(".git/hooks/#{timing}", 0755)
      end
    end

    desc "list", "display hooks those name starts with STRING"
    def list
      config.hooks.each_pair do | timing, hooks |
        say(timing, :blue)
        hooks.each do | hook |
          say("  #{hook[:class]}", :green, true)
          hook[:options].each_pair do | key, value |
            say(" " * 4 + key.to_s, :yellow, false)
            say(" : #{value}", nil, true)
          end
        end
      end
    end

    desc "test TIMING HOOK", "test HOOK on TIMING"
    def test(timing, hook)
      timing = timing.to_s.to_sym
      result = GitHook::Runner.invoke(timing, hook)
      say_status("success", "#{result}", :yellow)
    end

    private
    def config
      @config ||= GitHook::DSL.eval('.githooks')
    end
  end
end
