require 'hashr'
require 'git'
require 'git_hook'

module GitHook
  class Hook
    def self.gem_name(name)
      name.sub(/^[A-Z]/) { | match |
        match.downcase
      }.gsub(/::([A-Z])/) { | match |
        "-#{$1.to_s.downcase}"
      }.gsub(/[A-Z]/) { | match |
        "_#{match.downcase}"
      }
    end

    def self.class_name(name)
      name.sub(/^[a-z]/) { | match |
        match.upcase
      }.gsub(/\-([a-z])/) { | match |
        "::#{$1.to_s.upcase}"
      }.gsub(/_([a-z])/) { | match |
        $1.to_s.upcase
      }
    end

    def self.resolve(name)
      name = name.to_s
      if name =~ /^[a-z]/
        { class: class_name(name),
          require: name }
      else
        { class: name,
          require: gem_name(name) }
      end
    end

    def initialize(repo, timing, options)
      @git = repo
      @timing = timing
      @options = Hashr.new(options).freeze
    end

    def git
      @git
    end

    def timing
      @timing
    end

    def options
      @options
    end

    def invoke
      error("This Hook is abstruct class. please override your Hook")
      true
    end

    def info(msg); GitHook.io.info(msg); end
    def warn(msg); GitHook.io.warn(msg); end
    def error(msg); GitHook.io.error(msg); end
  end
end
