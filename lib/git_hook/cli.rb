require 'git_hook'
require 'thor'

module GitHook
  class CLI < Thor
    include Thor::Actions

    class_option 'no-color', type: :boolean, desc: 'Disable color output'
    class_option 'verbose', type: :boolean, desc: 'Verbose output'

    def initialize(*args)
      super(*args)
      GitHook.io.tty = (options['no-color'] ? Thor::Shell::BasicShell.new : shell)
      GitHook.io.verbose!(true) if options['verbose']
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
      Dir.chdir(GitHook.repo_dir)
      opts = {
        with_bundler: File.exist?('Gemfile')
      }
      unless File.exist?('.githooks')
        template('githooks.tt', '.githooks', opts)
      end

      GitHook::TIMINGS.each do | timing |
        opts[:timing] = timing
        template('hook.tt', ".git/hooks/#{timing}", opts)
        chmod(".git/hooks/#{timing}", 0755)
      end
    end

    desc "list [STRING]", "display hooks those name starts with STRING"
    def list(filter = nil)
    end
  end
end
