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

  # 2695702.pt.6vvt55AAO7KoZV2PnqW-KY6HzgJW2PEhm1esfU5AqurUxLAxgDwz_xdO06zGw3LqTZMiieIcLZSA29MuIjg4NQ
  # "1461373"
  #Two pieces of data necessary for this api    
  def harvest_data_request(account_id, personal_access_token)
    uri = URI.parse("https://api.harvestapp.com/api/v2/users/me.json")
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
    
    puts "HELOOOOOOOOOOOOOOOOOOOOOOOOO"
    puts response.body  
  end
  
end
