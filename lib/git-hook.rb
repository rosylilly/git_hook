require 'git-hook/version'
require 'git-hook/io'

module GitHook
  class << self
    def with_pretty_exception(&block)
      begin
        block.call
      rescue Exception => exception
        GitHook.io.error(exception.class)
        GitHook.io.info(">> #{exception.message}")
        exception.backtrace.each do | backtrace |
          GitHook.io.warn("+ #{backtrace}")
        end
      end
    end

    def io
      @io ||= GitHook::IO.new
    end
  end
end
