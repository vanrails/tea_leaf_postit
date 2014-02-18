module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def fix_datetime(dt)
    if dt != nil
      if logged_in? && !current_user.time_zone.blank?
        dt = dt.in_time_zone(current_user.time_zone)
      end
      dt.to_formatted_s(:long)
    end
  end
end
