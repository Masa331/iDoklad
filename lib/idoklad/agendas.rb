require 'json'

class Idoklad::Agendas
  def self.get_list
    response = Idoklad::ApiRequest.get '/v3/Account/Agendas'
    JSON.parse response.body
  end

  def self.get_detail(id)
    response = Idoklad::ApiRequest.get "/v3/Account/Agendas/#{id}"
    JSON.parse response.body
  end
end
