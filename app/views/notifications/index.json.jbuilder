json.notifications do
  json.array! @notifications do |notification|
    json.partial! 'json/notification', notification: notification
  end
end
json.current_page @notifications.current_page
json.total_count @notifications.total_count
