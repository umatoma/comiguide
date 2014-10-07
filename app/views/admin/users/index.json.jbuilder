json.users do
  json.array! @users do |user|
    json.partial! 'json/admin/user', user: user
  end
end
