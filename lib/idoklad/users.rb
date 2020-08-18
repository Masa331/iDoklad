require 'json'

class Idoklad::Users
  def self.get_list
    response = Idoklad::ApiRequest.get '/v3/Account/Users'
    JSON.parse response.body
  end
end
