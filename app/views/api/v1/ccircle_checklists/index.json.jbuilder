json.ccircle_checklists do
  json.array! @ccircle_checklists do |ccircle_checklist|
    json.(ccircle_checklist, :id, :comiket_id, :clayout_id, :space_no_sub, :day, :circle_name, :circle_url)
    json.(ccircle_checklist, :comment, :cost, :color, :updated_at, :created_at)
  end
end
