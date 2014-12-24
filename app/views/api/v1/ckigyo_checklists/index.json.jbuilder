json.comiket do
  json.(@comiket, :id, :event_name)
end
json.ckigyo_checklists do
  json.array! @ckigyo_checklists do |checklist|
    json.(checklist, :id, :ckigyo_id, :comment, :cost, :color, :updated_at, :created_at)
  end
end
