require 'git-hook'

module GitHook
  class DSL
    def self.eval(hooks_file)
      env = new
      env.load(hooks_file)
      env.to_hooks
    end

    def initialize
      @hooks = {}
    end

    # @param [String, Symbol, Class] name
    # @param [Symbol] timing GitHook::Timings
    # @param [Hash] options
    # @option options [String] gem require path
    def hook(name, timing, options = {})
      timing = timing.to_s.to_sym
      @hooks[timing] = [] if @hooks[timing].nil?
      @hooks[timing].push({
        name: name,
        options: options || {}
      })
    end

    # @param [String] path
    def load(path)
      instance_eval(open(path){|f| f.read })
    end
  end
end
