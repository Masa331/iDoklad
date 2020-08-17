require 'active_support/core_ext/object/blank'
require 'json'
require 'pry'

class Idoklad::PaymentOptions
  def self.all
    response = Idoklad::ApiRequest.get '/PaymentOptions'
    JSON.parse response.body
  end
end
