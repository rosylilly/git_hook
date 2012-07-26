require 'git_hook'

module GitHook
  class IO
    attr_accessor :tty

    def initialize
      @tty = STDOUT
      @verbose = false
    end

    def verbose!(bool)
      @verbose = !!bool
    end

    def info(msg)
      say(msg, nil)
    end

    def warn(msg)
      @verbose && say(msg, :yellow)
    end

    def error(msg)
      say(msg, :red)
    end

    private
    def say(msg, color)
      @tty.respond_to?(:say) ? @tty.say(msg, color) : @tty.puts(msg)
    end
  end
end
