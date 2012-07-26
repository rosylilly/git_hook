require 'git_hook'

module GitHook
  class IO
    attr_accessor :tty

    def initialize
      @tty = nil
    end

    def info(msg)
      say(msg, nil)
    end

    def warn(msg)
      say(msg, :yellow)
    end

    def error(msg)
      say(msg, :red)
    end

    private
    def say(msg, color)
      !@tty.nil? && @tty.say(msg, color)
    end
  end
end
