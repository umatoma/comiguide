json.ckigyo do
  json.(@ckigyo, :id, :kigyo_no, :name, :full_info, :map_style)
  json.ckigyo_links do
    json.array! @ckigyo.ckigyo_links do |link|
      json.url link.url
    end
  end
end
json.prev_ckigyo do
  json.(@prev_ckigyo, :id, :kigyo_no, :name, :full_info, :map_style) if @prev_ckigyo
end
json.next_ckigyo do
  json.(@next_ckigyo, :id, :kigyo_no, :name, :full_info, :map_style) if @next_ckigyo
end
json.ckigyo_checklists do
  json.array! @ckigyo_checklists do |checklist|
    json.(checklist, :id, :comment, :cost, :color)
  end
end
