json.extract! http_connection, :id, :toggl_api, :clockify_api, :harvest_api, :created_at, :updated_at
json.url http_connection_url(http_connection, format: :json)
