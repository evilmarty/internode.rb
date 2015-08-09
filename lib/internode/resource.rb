module Internode
  class Resource
    attr_reader :path, :client

    def initialize(options = {})
      @client = options.fetch(:client){ Internode.client }
      @path = options[:path]
    end

    def content
      @content ||= @client.get(path)
    end

    class << self
      def content_attr(*names)
        names.each do |name|
          name = name.to_s
          method_name = name.gsub(/\W+/, "_")

          define_method(method_name) do
            content.at_css(name).text
          end
        end
      end
    end
  end
end
