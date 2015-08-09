module Internode
  class Service < Resource
    def id
      service.text
    end

    def type
      service.attr("type").text
    end

    def details
      @details ||= Details.new(client: client, path: details_path)
    end

    def usage
      @usage ||= Usage.new(client: client, path: usage_path)
    end

  private

    def service
      @service ||= content.at_css("service")
    end

    def details_path
      content.at_css("resource[type='service']").attr("href").text
    end

    def usage_path
      content.at_css("resource[type='usage']").attr("href").text
    end
  end
end
