module Sovaa
  class JsonResponse < Hash
    attr_reader :etag
    def initialize(json, etag)
      super()
      self.merge!(Yajl::Parser.parse(json))
      @etag = etag
    end
  end
end
