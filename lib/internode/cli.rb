require "internode"
require "table_print"
require "thor"

module Internode
  class CLI < Thor
    class_option :username, aliases: %w(--user -u)
    class_option :password, aliases: %w(--pass -p)
    class_option :human, aliases: %w(-h), type: :boolean

    map %w(--version -v) => :print_version

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

    desc "--version, -v", "Print the version"
    def print_version
      puts Internode::VERSION
    end

  private

    def format(name)
      options[:human] ? :"#{name}_gb" : name
    end

    def account
      Account.new(options)
    end

    def print_error(error)
      puts "Internode: #{error}"
      exit 128
    end
  end
end
