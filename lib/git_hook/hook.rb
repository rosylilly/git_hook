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
  end
end
