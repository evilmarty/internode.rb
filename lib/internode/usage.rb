module Internode
  class Usage < Resource
    def id
      service.text
    end

    def type
      service.attr("type").text
    end

    def total
      traffic.text.to_i
    end

    def total_mb
      total / 1000 / 1000
    end

    def total_gb
      total_mb / 1000
    end

    def rollover
      traffic.attr("rollover").text
    end

    def plan_interval
      traffic.attr("plan-interval").text
    end

    def quota
      traffic.attr("quota").text.to_i
    end

    def quota_mb
      quota / 1000 / 1000
    end

    def quota_gb
      quota_mb / 1000
    end

    def percentage
      total.to_f / quota.to_f * 100.0
    end

  private

    def service
      @service ||= content.at_css("service")
    end

    def traffic
      @traffic ||= content.at_css("traffic")
    end
  end
end
