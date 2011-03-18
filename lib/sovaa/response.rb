module Sovaa
  class Response < Hash
    attr_reader :etag
    def initialize(json, etag)
      super(Yajl::Parser.parse(json))
      @etag = etag
    end
  end
end
