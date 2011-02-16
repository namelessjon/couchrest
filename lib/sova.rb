# Copyright 2008 J. Chris Anderson
# 
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
# 
#        http://www.apache.org/licenses/LICENSE-2.0
# 
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

require 'json'
    
require 'sova/http'
require 'sova/server'
require 'sova/database'

Sova::HTTP.adapter = :net_http

# = CouchDB, close to the metal
module Sova
  VERSION = '1.0.1'

  # The Sova module methods handle the basic JSON serialization 
  # and deserialization, as well as query parameters. The module also includes
  # some helpers for tasks like instantiating a new Database or Server instance.
  class << self

    # todo, make this parse the url and instantiate a Server or Database instance
    # depending on the specificity.
    def new(*opts)
      Server.new(*opts)
    end
    
    def parse url
      case url
      when /^(https?:\/\/)(.*)\/(.*)\/(.*)/
        scheme = $1
        host = $2
        db = $3
        docid = $4
      when /^(https?:\/\/)(.*)\/(.*)/
        scheme = $1
        host = $2
        db = $3
      when /^(https?:\/\/)(.*)/
        scheme = $1
        host = $2
      when /(.*)\/(.*)\/(.*)/
        host = $1
        db = $2
        docid = $3
      when /(.*)\/(.*)/
        host = $1
        db = $2
      else
        db = url
      end

      db = nil if db && db.empty?
      
      {
        :host => (scheme || "http://") + (host || "127.0.0.1:5984"),
        :database => db,
        :doc => docid
      }
    end

    attr_accessor :proxy
    
    # ensure that a database exists
    # creates it if it isn't already there
    # returns it after it's been created
    def database! url
      parsed = parse url
      cr = Sova.new(parsed[:host])
      cr.database!(parsed[:database])
    end
  
    def database url
      parsed = parse url
      cr = Sova.new(parsed[:host])
      cr.database(parsed[:database])
    end
    
    def paramify_url url, params = {}
      if params && !params.empty?
        query = params.collect do |k,v|
          v = v.to_json if %w{key startkey endkey}.include?(k.to_s)
          "#{k}=#{CGI.escape(v.to_s)}"
        end.join("&")
        url = "#{url}?#{query}"
      end
      url
    end
  end # class << self
end
