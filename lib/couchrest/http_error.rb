require "forwardable"

module CouchRest
  class HTTPError < StandardError
    extend Forwardable

    def_delegators :@response, :code, :headers, :body

    def initialize response
      @response = response
    end
  end

  class ResourceNotFound < HTTPError; end
  class Conflict < HTTPError; end
end
