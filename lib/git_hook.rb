require 'rbconfig'
require 'pathname'
require 'git_hook/version'
require 'git_hook/io'

module GitHook
  WINDOWS = RbConfig::CONFIG["host_os"] =~ %r!(msdos|mswin|djgpp|mingw)!
  NULL = WINDOWS ? 'NUL' : '/dev/null'

  TIMINGS = [:'applypatch-msg', :'pre-applypatch', :'post-applypatch', :'pre-commit', :'prepare-commit-msg', :'commit-msg', :'post-commit', :'pre-rebase', :'post-checkout', :'post-merge', :'pre-receive', :'update', :'post-receive', :'post-update', :'pre-auto-gc', :'post-rewrite']

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

    def repo_dir
      @repo_dir ||= Pathname.new(Dir.pwd).join(`git rev-parse --show-cdup 2> #{NULL}`.strip).expand_path
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

require 'git_hook/dsl'
require 'git_hook/hook'
require 'git_hook/hooks'
