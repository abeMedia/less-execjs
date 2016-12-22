# only exists to stop errors with jekyll-assets
module Less
  class Loader # :nodoc:
    def require(module_id)
      Less::FakeTree.new
    end
  end

  class FakeTree # :nodoc:
    def initialize
      @functions = {}
    end
    def functions
      @functions
    end
  end
end
