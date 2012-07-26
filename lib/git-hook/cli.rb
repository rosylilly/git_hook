require 'git-hook'
require 'thor'

module GitHook
  class CLI < Thor
    def initialize(*args)
      super(*args)
      GitHook.io.tty = (options['no-color'] ? Thor::Shell::BasicShell.new : shell)
    end
  end
end
