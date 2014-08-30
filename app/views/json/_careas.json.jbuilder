json.careas do
  json.array! careas do |carea|
    json.(carea, :id, :cmap_id, :name, :simple_name)
    json.cblocks do
      json.array! carea.cblocks do |cblock|
        json.(cblock, :id, :carea_id, :name)
      end
    end
  end
end
