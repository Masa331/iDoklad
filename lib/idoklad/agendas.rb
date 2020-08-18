require 'json'

class Idoklad::Agendas
  def self.get_list
    response = Idoklad::ApiRequest.get '/Account/Agendas'
    JSON.parse response.body
  end

  def self.current
    response = Idoklad::ApiRequest.get '/Account/CurrentAgenda'
    JSON.parse response.body
  end

  def self.get_detail(id)
    response = Idoklad::ApiRequest.get "/Account/Agendas/#{id}"
    JSON.parse response.body
  end
end
