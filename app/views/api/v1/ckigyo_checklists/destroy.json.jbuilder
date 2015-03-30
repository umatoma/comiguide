json.ckigyo_checklist do
  json.partial! 'api/v1/json/ckigyo_checklist', ckigyo_checklist: @ckigyo_checklist

  json.partial! 'api/v1/json/ckigyo', ckigyo: @ckigyo_checklist.ckigyo
end
