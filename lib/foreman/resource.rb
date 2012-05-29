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
      begin
        get(search(filter))
      rescue RestClient::ResourceNotFound
        []
      end
    end

    # Return a result, converted into class instance(s)
    def self.get(p = '')
      url    = (p.nil? or p.empty?) ? path : "#{path}/#{p}"
      result = JSON.parse(connection[URI.escape(url)].get.body)

      if result.respond_to?(:has_key?) and result.has_key?(self.class_name)
        self.new(result[self.class_name])
      elsif result.respond_to?(:map)
        result.map { |r| self.new(r[self.class_name]) }
      else
        self.new(result)
      end
    end

    # collection path, such as foreman/hosts
    def self.path
      "#{self.class_name}s"
    end

    protected
    def self.class_name
      self.to_s.downcase.gsub(/^.*::/, '')
    end

    def self.search(q)
      (q.nil? or q.empty?) ? '' : "?search=#{q}"
    end

    def rid
      Raise "Abstracted ID, must be defined per Resource class"
    end

    def get(p)
      url = p.empty? ? rid : "#{rid}/#{p}"
      self.class.get url
    end

    def <=>(other)
      to_s <=> other.to_s
    end

  end
end
