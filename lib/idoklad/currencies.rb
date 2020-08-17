require 'active_support/core_ext/object/blank'
require 'json'
require 'pry'

class Idoklad::Currencies
  def self.all
    response = Idoklad::ApiRequest.get '/Currencies'
    JSON.parse response.body
  end
end
