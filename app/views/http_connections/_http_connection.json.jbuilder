json.extract! http_connection, :id, :toggl_api, :clockify_api, :harvest_personal_access_token, :harvest_account_id, :created_at, :updated_at
json.url http_connection_url(http_connection, format: :json)
