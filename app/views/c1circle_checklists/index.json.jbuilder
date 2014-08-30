json.c1circle_checklists do
  json.array! @c1circle_checklists do |checklist|
    json.partial! 'json/c1circle_checklist', c1circle_checklist: checklist
    json.c1block_id checklist.c1layout.c1block_id
    json.c1blocks do
      json.array! @c1blocks do |c1block|
        json.(c1block, :id, :comic1_id, :name, :pos_x, :pos_y)
      end
    end
    json.c1layouts do
      json.array! checklist.c1layout.c1block.c1layouts do |c1layout|
        json.(c1layout, :id, :c1block_id, :space_no, :layout, :pos_x, :pos_y)
      end
    end
  end
end
json.new_c1circle_checklist do
  json.comic1_id @comic1.id
  json.c1layout_id @c1blocks.first.c1layouts.first.id
  json.c1block_id @c1blocks.first.id
  json.c1blocks do
    json.array! @c1blocks do |c1block|
      json.(c1block, :id, :comic1_id, :name, :pos_x, :pos_y)
    end
  end
  json.c1layouts do
    json.array! @c1blocks.first.c1layouts do |c1layout|
      json.(c1layout, :id, :c1block_id, :space_no, :layout, :pos_x, :pos_y)
    end
  end
end
