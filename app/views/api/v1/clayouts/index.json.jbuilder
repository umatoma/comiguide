json.cblock do
  json.partial! 'api/v1/json/cblock', cblock: @cblock

  json.clayouts @clayouts do |clayout|
    json.partial! 'api/v1/json/clayout', clayout: clayout
  end
end
