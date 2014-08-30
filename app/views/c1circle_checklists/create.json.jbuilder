json.c1circle_checklist do
  json.partial! 'json/c1circle_checklist', c1circle_checklist: @c1circle_checklist
  json.c1block_id @c1circle_checklist.c1layout.c1block_id
  json.c1blocks do
    json.array! @c1blocks do |c1block|
      json.(c1block, :id, :comic1_id, :name, :pos_x, :pos_y)
    end
  end
  json.c1layouts do
    json.array! @c1layouts do |c1layout|
      json.(c1layout, :id, :c1block_id, :space_no, :layout, :pos_x, :pos_y)
    end
  end
end
