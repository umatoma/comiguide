json.ckigyo_checklists do
  json.array! ckigyo_checklists do |checklist|
    json.(checklist, :id, :ckigyo_id, :comment, :cost, :color)
    json.partial! 'json/ckigyo', ckigyo: checklist.ckigyo
    json.form do
      json.update false
      json.destroy false
    end
  end
end
