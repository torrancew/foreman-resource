require 'foreman/resource'

module Foreman
  class Hostgroup < Resource

    attr_reader :name, :id

    def initialize(opts = {})
      @name = opts['name'] || raise('Hostgroups require a name')
      @id   = opts['id']   || raise('Hostgroups require an ID')
    end

    def path
      "/hostgroups/#{id}"
    end

    def rid
      id
    end

    def to_s
      name
    end

    def hosts
      Host.all("hostgroup = #{name}")
    end

  end
end
