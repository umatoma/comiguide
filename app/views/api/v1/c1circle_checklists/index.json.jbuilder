json.c1circle_checklists @c1circle_checklists do |c1circle_checklist|
  json.partial! 'api/v1/json/c1circle_checklist', c1circle_checklist: c1circle_checklist

  json.clayout do
    json.partial! 'api/v1/json/c1layout', c1layout: c1circle_checklist.c1layout

    json.cblock do
      json.partial! 'api/v1/json/c1block', c1block: c1circle_checklist.c1layout.c1block
    end
  end
end
