json.c1circle_checklists do
  json.(@c1circle_checklist, :id, :comic1_id, :c1layout_id, :circle_name, :circle_url, :comment, :cost, :color)
  json.(@c1circle_checklist, :updated_at, :created_at)
end
