json.user do
  json.(@user, :id, :username)
end
json.api_token do
  json.token @api_token.token
end
