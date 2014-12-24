json.cblock do
  json.(@cblock, :id, :carea_id, :name)
end
json.clayouts do
  json.array! @clayouts do |clayout|
    json.(clayout, :id, :space_no, :layout)
  end
end
