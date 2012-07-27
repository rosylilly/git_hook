require 'git_hook/hooks'
require 'ripper'

class GitHook::Hooks::RubySyntaxCheck < GitHook::Hook
  def invoke
    result = true
    extensions = options[:extensions] || ['rb']
    git.status.changed.merge(git.status.added).each_pair do | file, obj |
      if file =~ /\.(#{extensions.join('|')})$/
        parser = Parser.new(open(file){|f| f.read}, file)
        parser.parse()
        parser.errors.each do | err |
          error(err)
        end
        parser.warns.each do | warning |
          warn(warning)
        end
        result = result && parser.errors.empty?
      end
    end

    return result
  end

  class Parser < Ripper
    def initialize(*args)
      super(*args)
      @errors = []
      @warns = []
    end
    attr_reader :errors, :warns

    def compile_error(msg)
      @errors.push(msg)
    end

    def warn(msg, *args)
      @warns.push(msg)
    end
  end
end
