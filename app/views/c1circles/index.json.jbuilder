json.c1circles do
  json.array! @c1circles do |c1circle|
    json.partial! 'json/c1circle', c1circle: c1circle
    json.c1layout do
      json.partial! 'json/c1layout', c1layout: c1circle.c1layout
      json.c1block do
        json.partial! 'json/c1block', c1block: c1circle.c1layout.c1block
      end
    end
  end
end
json.current_page @c1circles.current_page
json.total_count @c1circles.total_count
