json.c1circles do
  json.array! @c1circles do |c1circle|
    json.(c1circle, :id, :comic1_id, :c1layout_id, :space_no_sub, :name, :kana, :url, :updated_at, :created_at)
  end
end
