# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def area(page_area)
    @area = page_area
  end
  def navigate_to(name, url, area)
    link_to name, url, :class => @area == area ? 'ui-btn-active' : nil, :'data-ajax' => 'false'
  end
  def title(page_title)
    content_for(:title) { h page_title }
  end
end
