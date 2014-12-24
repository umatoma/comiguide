json.c1block do
  json.array! @c1blocks do |c1block|
    json.(c1block, :id, :comic1_id, :name, :pos_x, :pos_y)
  end
end
