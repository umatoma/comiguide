module ApplicationHelper
  def set_page_sub_title(sub_title)
    content_for :title do
      sub_title
    end
  end

  def uniq_view_id
    "#{request.filtered_parameters['action']}_#{controller_view_class}"
  end

  def controller_view_class
    request.filtered_parameters['controller'].gsub('/', '_')
  end
end
