class HttpConnection
  include Mongoid::Document
  include Mongoid::Timestamps
  field :toggl_api, type: String
  field :clockify_api, type: String
  field :harvest_account_id, type: String
  field :harvest_personal_access_token, type: String
end
