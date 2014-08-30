json.partial! 'json/user', user: @user
json.notifications do
  json.array! @notifications do |notification|
    json.(notification, :id, :title, :content, :status, :updated_at, :created_at)
  end
end
json.ckigyo_checklists do
  json.count @ckigyo_checklists.size
end
json.partial! 'json/ccircle_checklists', ccircle_checklists: @ccircle_checklists
