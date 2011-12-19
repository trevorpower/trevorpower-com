# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def area(page_area)
    @page = page_area
  end
  def navigation_class(area)
    (@page || controller.controller_name.downcase).to_s == area.to_s ? 'active' : nil
  end
  def navigate_to(name, url, area = nil)
    link_to name, url, :class => navigation_class(area || name.downcase)
  end
  def title(page_title)
    content_for(:title) { h page_title }
  end
end
