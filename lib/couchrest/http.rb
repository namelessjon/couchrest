require "httpi"
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

  module HTTP
    extend self

    attr_accessor :adapter

    def request method, uri, doc=nil, headers={}
      request = HTTPI::Request.new
      request.url     = uri
      request.proxy   = CouchRest.proxy if CouchRest.proxy
      request.body    = doc if doc
      request.headers = {
        "Content-Type" => "application/json",
        "Accept"       => "application/json"
      }.merge(headers)

      response = HTTPI.request(method, request, adapter)
      raise http_error(response) if response.error?
      response
    end

    def put(uri, doc=nil, headers={})
      response = request(:put, uri, doc.to_json, headers)
      JSON.parse(response.body, :max_nesting => false)
    end

    def get(uri)
      response = request(:get, uri)
      JSON.parse(response.body, :max_nesting => false)
    end

    def post(uri, doc=nil)
      response = request(:post, uri, doc.to_json)
      JSON.parse(response.body, :max_nesting => false)
    end

    def delete(uri)
      response = request(:delete, uri)
      JSON.parse(response.body, :max_nesting => false)
    end

    def copy(uri, destination) 
      headers = {'X-HTTP-Method-Override' => 'COPY', 'Destination' => destination}
      response = request(:post, uri, nil, headers)
      JSON.parse(response.body, :max_nesting => false)
    end 

    private

    def http_error response
      klass = 
        case response.code
        when 404 then
          CouchRest::ResourceNotFound
        when 409 then
          CouchRest::Conflict
        else
          CouchRest::HTTPError
        end
      klass.new(response)
    end
  end
end
