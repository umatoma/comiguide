json.c1block do
  json.partial! 'api/v1/json/c1block', c1block: @c1block

  json.c1layouts @c1layouts do |c1layout|
    json.partial! 'api/v1/json/c1layout', c1layout: c1layout
  end
end
