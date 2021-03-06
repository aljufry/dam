module ApplicationHelper
  extend ActiveSupport::Memoizable

  def system_status
    status = ""
    Rails.logger.info "Inside get_system_status."
    if Agent.down.size > 0
      status = "inactive"
    elsif Agent.testing.size > 0
      status = "testing"
    else
      status = "active"
    end
    status
  end

  memoize :system_status
end
