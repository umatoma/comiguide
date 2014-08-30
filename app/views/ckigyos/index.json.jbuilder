json.ckigyos do
  json.array! @ckigyos do |ckigyo|
    json.(ckigyo, :id, :kigyo_no, :name, :full_info, :map_style)
  end
end
