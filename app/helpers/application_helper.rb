module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def fix_datetime(dt)
    if dt != nil
      dt.to_formatted_s(:long)
    end
  end
end
