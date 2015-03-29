json.ckigyo_checklists @ckigyo_checklists do |checklist|
  json.partial! 'api/v1/json/ckigyo_checklist', ckigyo_checklist: checklist

  json.ckigyo do
    json.partial! 'api/v1/json/ckigyo', ckigyo: checklist.ckigyo
  end
end
