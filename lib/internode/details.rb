module Internode
  class Details < Resource
    content_attr :id, :username, :plan, :carrier, :speed
    content_attr "usage-rating", "rollover", "excess-charged", "excess-shaped", "excess-restrict-access", "plan-interval", "plan-cost"

    def type
      content.at_css("service").attr("type").text
    end

    def quota
      content.at_css("quota").text.to_i
    end

    def quota_mb
      quota / 1000 / 1000
    end

    def quota_gb
      quota_mb / 1000
    end
  end
end
