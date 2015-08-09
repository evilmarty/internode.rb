module Internode
  class Account < Resource
    PATH = "/api/v1.5"

    def initialize(options = {})
      client = options.fetch(:client){ Client.new(username: options[:username], password: options[:password]) }
      path = options.fetch(:path){ PATH }
      super(client: client, path: path)
    end

    def services
      @services ||= content.css("services service").map do |node|
        Service.new(client: client, path: node.attr("href").text)
      end
    end

    def details
      concurrent_map(&:details)
    end

    def usage
      concurrent_map(&:usage)
    end

  private

    # Used to allow performing API requests in parallal instead of series
    def concurrent_map
      threads = services.map{|s| Thread.new{ yield s } }
      threads.each(&:join)
      threads.map(&:value)
    end
  end
end
