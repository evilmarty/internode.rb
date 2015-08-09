require "rubygems"
require "bundler/setup"

require "internode/version"

module Internode
  autoload :Account,  "internode/account"
  autoload :Client,   "internode/client"
  autoload :Details,  "internode/details"
  autoload :Resource, "internode/resource"
  autoload :Service,  "internode/service"
  autoload :Usage,    "internode/usage"

  def self.client
    @client ||= Client.new
  end

  def self.client=(client)
    @client = client
  end
end
