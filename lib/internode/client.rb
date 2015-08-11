require "httpclient"
require "oga"

module Internode
  class Client
    URL = "https://customer-webtools-api.internode.on.net"

    class ServerError < RuntimeError; end

    def initialize(options = {})
      username = options[:username] || ENV["INTERNODE_USERNAME"]
      password = options[:password] || ENV["INTERNODE_PASSWORD"]
      @url = options.fetch(:url){ URL }
      @client = HTTPClient.new
      @client.set_auth(@url, username, password)
      @client.cookie_manager = nil
    end

    def get(path, *args)
      url = "#{@url}#{path}"
      content = @client.get_content(url)

      Oga.parse_xml(content).at_css("internode api")

    rescue HTTPClient::BadResponseError => err
      raise ServerError.new("#{err.res.status_code} #{err.res.reason}")
    end
  end
end
