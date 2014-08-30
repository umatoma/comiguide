json.ckigyo do
  json.(ckigyo, :id, :kigyo_no, :name, :full_info, :map_style)
  json.ckigyo_path ckigyo_path(ckigyo)
  json.map_flag false
end
