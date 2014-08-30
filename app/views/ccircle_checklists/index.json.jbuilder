json.ccircle_checklists do
  json.array! @ccircle_checklists do |ccircle_checklist|
    json.partial! 'json/ccircle_checklist', ccircle_checklist: ccircle_checklist
    json.cblock_id ccircle_checklist.clayout.cblock.id
    json.carea_id ccircle_checklist.clayout.cblock.carea_id
    json.partial! 'json/careas', careas: @careas
  end
end
json.new_ccircle_checklist do
  json.comiket_id @comiket.id
  json.carea_id @careas.first.id
  json.cblock_id @careas.first.cblocks.first.id
  json.partial! 'json/careas', careas: @careas
end
