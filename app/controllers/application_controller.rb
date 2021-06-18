class ApplicationController < ActionController::Base
  def toggl_data_request(api_key)
    uri = URI.parse("https://api.track.toggl.com/api/v8/me?with_related_data=true")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(api_key, "api_token")

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  
    data = JSON.pretty_generate(JSON.parse(response.body))
    return data
  end
  
end
