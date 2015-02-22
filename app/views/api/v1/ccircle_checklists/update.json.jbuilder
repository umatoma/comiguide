json.ccircle_checklist do
  json.partial! 'api/v1/json/ccircle_checklist', ccircle_checklist: @ccircle_checklist

  json.clayout do
    json.partial! 'api/v1/json/clayout', clayout: @ccircle_checklist.clayout

    json.cblock do
      json.partial! 'api/v1/json/cblock', cblock: @ccircle_checklist.clayout.cblock

      json.carea do
        json.partial! 'api/v1/json/carea', carea: ccircle_checklist.clayout.cblock.carea
      end
    end
  end
end
