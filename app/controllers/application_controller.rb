class ApplicationController < ActionController::Base
  def toggl_data_request(toggl_api_key)
    uri = URI.parse("https://api.track.toggl.com/api/v8/me?with_related_data=true")
    request = Net::HTTP::Get.new(uri)
    request.basic_auth(toggl_api_key, "api_token")

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  
    data = JSON.pretty_generate(JSON.parse(response.body))
    return data
  end
  
  def clockify_data_request(clockify_api_key)
    uri = URI.parse("https://api.clockify.me/api/v1/user")
    request = Net::HTTP::Get.new(uri)
    request.content_type = "application/json"
    request["X-Api-Key"] = clockify_api_key
    
    req_options = {
      use_ssl: uri.scheme == "https",
    }
    
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    data = JSON.pretty_generate(JSON.parse(response.body))
    return data
  end

  #Two pieces of data necessary for this api   
  #ONLY GETS LAST TIME ENTRY
  def harvest_data_request(account_id, personal_access_token)
    uri = URI.parse("https://api.harvestapp.com/api/v2/time_entries?per_page=1&ref=last")
    request = Net::HTTP::Get.new(uri)
    request["Harvest-Account-Id"] = account_id
    request["Authorization"] = "Bearer #{personal_access_token}"
    request["User-Agent"] = "Harvest API Example"
    
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
