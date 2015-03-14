json.c1circle_checklist do
  json.partial! 'api/v1/json/c1circle_checklist', c1circle_checklist: @c1circle_checklist

  json.c1layout do
    json.partial! 'api/v1/json/c1layout', clayout: @c1circle_checklist.c1layout

    json.c1block do
      json.partial! 'api/v1/json/c1block', cblock: @c1circle_checklist.c1layout.c1block
    end
  end
end
