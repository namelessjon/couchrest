require "forwardable"

module CouchRest
  class HttpError < StandardError
    extend Forwardable

    def_delegators :@response, :code, :headers, :body

    def initialize response
      @response = response
    end
  end

  class ResourceNotFound < HttpError; end
  class Conflict < HttpError; end
end
