# def api_get action, params={}, version="1"
#   get "/api/v#{version}/#{action}", params
#   JSON.parse(response.body) rescue {}
# end

def api_get action, params={}, version="1"
  get "/#{action}", params
  JSON.parse(response.body) rescue {}
end

def api_post action, params={}, version="1"
  post "/api/v#{version}/#{action}", params
  JSON.parse(response.body) rescue {}
end

def api_delete action, params={}, version="1"
  delete "/api/v#{version}/#{action}", params
  JSON.parse(response.body) rescue {}
end

def api_put action, params={}, version="1"
  put "/api/v#{version}/#{action}", params
  JSON.parse(response.body) rescue {}
end
