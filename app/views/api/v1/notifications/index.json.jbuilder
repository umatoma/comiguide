json.notifications @notifications do |notification|
  json.partial! 'api/v1/json/notification', notification: notification
end
