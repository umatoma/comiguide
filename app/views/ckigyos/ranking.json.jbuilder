json.ckigyos do
  json.array! @ckigyos do |ckigyo|
    json.(ckigyo, :id, :kigyo_no, :name, :full_info)
    json.ckigyo_path ckigyo_path(ckigyo)
    json.rank @ckigyos.index(ckigyo) + 1
    json.count @ckigyo_ranks[ckigyo.id]
  end
end
