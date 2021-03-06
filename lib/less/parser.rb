module Less
  # Convert lesscss source into an abstract syntax Tree
  class Parser
    class << self
      def backend
        @backend ||= ExecJS::ExternalRuntime.new(
          name:        'Node.js (V8)',
          command:     %w(nodejs node),
          runner_path: File.expand_path('../runner.js', __FILE__)
        )
      end
    end

    # Construct and configure new Less::Parser
    #
    # @param [Hash] opts configuration options
    # @option opts [Array] :paths a list of directories to search when handling \@import statements
    # @option opts [String] :filename to associate with resulting parse trees (useful for generating errors)
    # @option opts [Pathname] :custom_functions a file that defines any custom functions
    def initialize(options = {})
      @options = Less.defaults.merge(options)
      @context = self.class.backend.compile(compiler_source)
    end

    # Convert `less` source into a abstract syntaxt tree
    # @param [String] less the source to parse
    # @param [Hash] opts render options
    # @return [Less::Tree] the parsed tree
    def parse(less, options = {})
      old_node_env = ENV['NODE_PATH']
      opts = @options.merge(options)
      if opts[:custom_functions]
        ENV['NODE_PATH'] = "#{opts[:custom_functions].dirname}:#{old_node_env}"
        opts[:custom_functions] = opts[:custom_functions].to_s.split('/').last
      end
      Result.new @context.call('render', less, opts)
    rescue ExecJS::ProgramError => e
      raise ParseError.new(e.message)
    ensure
      ENV['NODE_PATH'] = old_node_env
    end

    protected

    def compiler_source
      File.read(File.expand_path('../compiler.js', __FILE__))
    end
  end

  class Result # :nodoc:
    attr_reader :css, :imports

    def initialize(result = {})
      @css = result['css'] || ''
      @imports = result['imports'] || []
    end

    def to_css
      @css
    end
  end
end
