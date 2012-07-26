require 'git_hook'
require 'thor'

module GitHook
  class CLI < Thor
    class_option 'no-color', type: :boolean, desc: 'Disable color output'
    class_option 'verbose', type: :boolean, desc: 'Verbose output'

    def initialize(*args)
      super(*args)
      GitHook.io.tty = (options['no-color'] ? Thor::Shell::BasicShell.new : shell)
      GitHook.io.verbose!(true) if options['verbose']
    end

    desc "list [STRING]", "display hooks those name starts with STRING"
    def list(filter = nil)
    end
  end
end
