module ApplicationHelper
  include Pagy::Frontend
  def full_title page_title
    base_title = t "helpers.application_helper.base_title"
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end
end
