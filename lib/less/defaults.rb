module Less
  module Defaults # :nodoc:
    def defaults
      @defaults ||= { paths: [], custom_functions: nil }
    end

    def paths
      defaults[:paths]
    end

    def custom_functions
      defaults[:custom_functions]
    end
  end
end
