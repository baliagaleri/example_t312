json.extract! user, :id, :rut, :name, :created_at, :updated_at
json.url user_url(user, format: :json)