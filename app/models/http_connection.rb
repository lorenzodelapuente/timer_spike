class HttpConnection
  include Mongoid::Document
  include Mongoid::Timestamps
  field :toggl_api, type: String
  field :clockify_api, type: String
  field :harvest_api, type: String
end
