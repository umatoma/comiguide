json.ccircle_checklists do
  json.array! ccircle_checklists do |checklist|
    json.(checklist, :id,
                     :clayout_id,
                     :day,
                     :circle_name,
                     :circle_url,
                     :comment,
                     :cost,
                     :color,
                     :updated_at,
                     :created_at)
    json.cblock_id checklist.clayout.cblock.id
    json.carea_id checklist.clayout.cblock.carea_id
    json.form do
      json.update false
      json.destroy false
    end
  end
end
