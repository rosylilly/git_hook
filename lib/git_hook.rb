require 'pathname'
require 'git-hook/version'
require 'git-hook/io'

module GitHook
  WINDOWS = RbConfig::CONFIG["host_os"] =~ %r!(msdos|mswin|djgpp|mingw)!
  NULL = WINDOWS ? 'NUL' : '/dev/null'

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

    def git_dir
      @git_dir ||= begin
                   dir = `git rev-parse --git-dir 2> #{NULL}`.strip
                   raise NotAGitRepository unless $? == 0
                   Pathname.new(dir).expand_path
                 end
    end

    def hooks_dir
      git_dir.join('hooks')
    end
  end
end
