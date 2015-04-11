json.notification do
  json.(@notification, :id, :title, :content, :status, :status_name, :target, :updated_at, :created_at)
end
