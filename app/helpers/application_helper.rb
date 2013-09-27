module ApplicationHelper

  def fix_url url
    url.starts_with?("http:") ? url : "http://#{url}"
  end

  def pretty_date dt
    dt = dt.in_time_zone(current_user.time_zone || Time.zone.name) if logged_in?
    dt.strftime("%m/%d/%Y %l:%M%P %Z")
  end

  def default_time_zone
    logged_in? && !current_user.time_zone.nil? ? current_user.time_zone : Time.zone.name
  end

end
