json.ccircle_checklist do
  json.(@ccircle_checklist, :id, :comiket_id, :clayout_id, :space_no_sub, :day, :circle_name, :circle_url)
  json.(@ccircle_checklist, :comment, :cost, :color, :updated_at, :created_at)
end
