require 'rubygems'
require 'uri'
require 'json'
require 'rest_client'

module Foreman
  class Resource

    def self.connect opts = {}
      url  = opts.delete(:url) || raise('Must provide URL')
      hdrs = { :accept => :json, :content_type => :json }
      
      opts[:headers]      = hdrs
      opts[:timeout]      = 60
      opts[:open_timeout] = 10

      @@resource =  RestClient::Resource.new(url, opts)
    end

    def self.connection
      @@resource || raise("Must Connect First")
    end

    def self.all(filter = "")
      get(search(filter))
    rescue RestClient::ResourceNotFound
      []
    end

    def self.get(p = "")
      url = p.empty? ? path : "#{path}/#{p}"
      JSON.parse connection[URI.escape(url)].get.body
    end

    # collection path, such as foreman/hosts
    def self.path
      "#{self.to_s.downcase.gsub(/^.*::/,"")}s"
    end

    protected

    def self.search q
      return "" if q.nil? or q.empty?
      "?search=#{q}"
    end

    def rid
      Raise "Abstracted ID, must be defined per Resource class"
    end

    def get p
      url = p.empty? ? rid : "#{rid}/#{p}"
      self.class.get url
    end

    def <=> other
      to_s <=> other.to_s
    end

  end
end
