json.partial! 'json/user', user: @user
json.notifications do
  json.array! @notifications do |notification|
    json.(notification, :id, :title, :content, :status, :updated_at, :created_at)
  end
end
json.ckigyo_checklists do
  json.count @ckigyo_checklists.size
end
json.partial! 'json/ccircle_checklists', ccircle_checklists: @ccircle_checklists.first(5)
json.c1circle_checklists do
  json.array! @c1circle_checklists.first(5) do |checklist|
    json.partial! 'json/c1circle_checklist', c1circle_checklist: checklist
    json.c1block_id checklist.c1layout.c1block_id
    json.c1blocks do
      json.array! @comic1.c1blocks do |c1block|
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
json.list_count do
  json.ccircle_checklists @ccircle_checklists.size
  json.c1circle_checklists @c1circle_checklists.size
end
