json.c1block do
  json.(@c1block, :id, :comic1_id, :name, :pos_x, :pos_y)
end
json.c1layouts do
  json.array! @c1layouts do |c1layout|
    json.(c1layout, :id, :c1block_id, :space_no, :layout, :pos_x, :pos_y)
  end
end
