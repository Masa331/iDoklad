require 'json'
class Idoklad::Contacts
  def self.get_list
    response = Idoklad::ApiRequest.get '/developer/api/v2/Contacts'
    JSON.parse response.body
  end

  def self.create(attributes)
    response = Idoklad::ApiRequest.post '/developer/api/v2/Contacts', attributes
    JSON.parse response.body
  end
end
