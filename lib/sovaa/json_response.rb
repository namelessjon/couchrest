module Sovaa
  class JsonResponse < Hash
    attr_reader :etag
    def initialize(json, etag)
      super()
      self.merge!(json)
      @etag = etag
    end
  end
end
