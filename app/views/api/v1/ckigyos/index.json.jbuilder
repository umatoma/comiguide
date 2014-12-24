json.comiket do
  json.(@comiket, :id, :event_name)
end
json.ckigyos do
  json.array! @ckigyos do |ckigyo|
    json.(ckigyo, :id, :kigyo_no, :name, :x, :y, :w, :h)
  end
end
