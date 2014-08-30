json.ccircle_checklist do
  json.partial! 'json/ccircle_checklist', ccircle_checklist: @ccircle_checklist
  json.cblock_id @ccircle_checklist.clayout.cblock.id
  json.carea_id @ccircle_checklist.clayout.cblock.carea_id
  json.partial! 'json/careas', careas: @careas
end
