json.users do
  json.array! @users do |user|
    json.partial! 'json/admin/user', user: user
  end
end
json.current_page @users.current_page
json.total_count @users.total_count
