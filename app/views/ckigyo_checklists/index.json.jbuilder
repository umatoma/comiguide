json.ckigyo_checklists do
  json.array! @ckigyo_checklists do |checklist|
    json.(checklist, :id, :ckigyo_id, :comment, :cost, :color)
    json.ckigyo do
      json.(checklist.ckigyo, :id, :kigyo_no, :name, :full_info, :map_style)
    end
  end
end
json.new_ckigyo_checklist do
  json.ckigyo_id @ckigyos.first.id
end
