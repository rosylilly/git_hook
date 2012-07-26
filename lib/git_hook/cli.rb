require 'git-hook'
require 'thor'

module GitHook
  class CLI < Thor
    class_option 'no-color', type: :boolean, desc: 'Disable color output'

    def initialize(*args)
      super(*args)
      GitHook.io.tty = (options['no-color'] ? Thor::Shell::BasicShell.new : shell)
    end

    desc "list [STRING]", "display hooks those name starts with STRING"
    def list(filter = nil)
    end
  end
end
