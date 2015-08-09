require "internode"
require "table_print"
require "thor"

module Internode
  class CLI < Thor
    class_option :user, aliases: :u
    class_option :password, aliases: :p
    class_option :human, aliases: :h, type: :boolean

    desc "list", "List services"
    def list
      tp account.details, :id, :type, :plan, format(:quota), :speed
    rescue Client::ServerError => err
      print_error(err)
    end

    desc "usage", "Show usage for service"
    def usage
      tp account.usage, :id, :type, format(:total), format(:quota), :percentage, :plan_interval, :rollover
    rescue Client::ServerError => err
      print_error(err)
    end

  private

    def format(name)
      options[:human] ? :"#{name}_gb" : name
    end

    def account
      Account.new(username: options[:user], password: options[:password])
    end

    def print_error(error)
      puts "Internode: #{error}"
      exit 128
    end
  end
end