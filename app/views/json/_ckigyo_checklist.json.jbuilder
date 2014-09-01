json.(ckigyo_checklist, :id, :ckigyo_id, :comment, :cost, :color, :updated_at, :created_at)
json.partial! 'json/ckigyo', ckigyo: ckigyo_checklist.ckigyo
