json.notifications do
  json.array! @notifications do |notification|
    json.(notification, :id, :title, :content, :status, :status_name, :updated_at, :created_at)
  end
end
