require 'git_hook'

module GitHook
  class DSL
    def self.eval(hooks_file)
      env = new
      env.load(hooks_file)
      env.hooks
    end

    def initialize
      @hooks = {}
    end
    attr_reader :hooks

    # @param [String, Symbol, Class] name
    # @param [Symbol] timing GitHook::Timings
    # @param [Hash] options
    # @option options [String] gem require path
    def hook(name, timing, options = {})
      timing = timing.to_s.to_sym
      options = options || {}
      @hooks[timing] = [] if @hooks[timing].nil?

      obj = GitHook::Hook.resolve(name)
      obj[:require] = options[:require] if options[:require]
      Kernel.instance_eval do
        require obj[:require]
      end
      obj[:class] = Kernel.const_get(obj[:class])
      obj[:options] = options

      @hooks[timing].push(obj)
    end

    GitHook::TIMINGS.each do | timing |
      define_method(timing.to_s.gsub('-', '_')) do | name, *options |
        hook(name, timing, options.first)
      end
    end

    # @param [String] path
    def load(path)
      instance_eval(open(path){|f| f.read })
    end
  end
end
