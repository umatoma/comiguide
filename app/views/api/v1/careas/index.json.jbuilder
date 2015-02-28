json.careas @careas do |carea|
  json.partial! 'api/v1/json/carea', carea: carea

  json.cblocks carea.cblocks do |cblock|
    json.partial! 'api/v1/json/cblock', cblock: cblock
  end
end
