json.ckigyo_checklist do
  json.id @ckigyo_checklist.id
  json.comment @ckigyo_checklist.comment
  json.cost @ckigyo_checklist.cost
  json.color @ckigyo_checklist.color
  json.ckigyo do
    json.id @ckigyo_checklist.ckigyo.id
    json.kigyo_no @ckigyo_checklist.ckigyo.kigyo_no
    json.name @ckigyo_checklist.ckigyo.name
    json.full_info @ckigyo_checklist.ckigyo.full_info
  end
end
