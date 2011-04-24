require "httpi"
require "uri"
require "forwardable"
require 'sovaa/json_response'

module Sovaa
  class HTTPError < StandardError
    extend Forwardable

    def_delegators :@response, :code, :headers, :body

    def initialize response
      @response = response
    end
  end
  class NotFound < HTTPError; end
  class Conflict < HTTPError; end
  class Invalid < HTTPError; end

  module HTTP
    extend self

    attr_accessor :adapter

    def request method, uri, doc=nil, headers={}
      uri = URI.parse(uri)
      request = HTTPI::Request.new
      request.url = uri
      request.auth.basic uri.user, uri.password if uri.user && uri.password
      request.proxy = Sovaa.proxy if Sovaa.proxy
      request.body = doc if doc
      request.headers = {
        "Content-Type" => "application/json",
        "Accept" => "application/json"
      }.merge(headers)

      response = HTTPI.request(method, request, adapter)
      raise http_error(response) if response.error?
      response
    end

    def put(uri, doc=nil, headers={})
      doc = Yajl::Encoder.encode(doc) if doc
      response = request(:put, uri, doc, headers)
      parsed_response(response)
    end

    def get(uri)
      response = request(:get, uri)
      parsed_response(response)
    end

    def post(uri, doc=nil)
      doc = Yajl::Encoder.encode(doc) if doc
      response = request(:post, uri, doc)
      parsed_response(response)
    end

    def delete(uri)
      response = request(:delete, uri)
      parsed_response(response)
    end

    def copy(uri, destination)
      headers = {'X-HTTP-Method-Override' => 'COPY', 'Destination' => destination}
      response = request(:post, uri, nil, headers)
      parsed_response(response)
    end

    def parsed_response(response)
      parsed = Yajl::Parser.parse(response.body)
      parsed.is_a?(Hash) ? JsonResponse.new(parsed, response.headers['ETag']) ? parsed
    end

    private

    def http_error response
      klass =
        case response.code
        when 404 then
          NotFound
        when 409 then
          Conflict
        else
          HTTPError
        end
      klass.new(response)
    end
  end
end
