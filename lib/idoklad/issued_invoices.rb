require 'json'

class Idoklad::IssuedInvoices
  def self.get_list
    response = Idoklad::ApiRequest.get '/developer/api/v2/IssuedInvoices'
    JSON.parse response.body
  end

  def self.get_invoice(invoice_id)
    response = Idoklad::ApiRequest.get "/developer/api/v2/IssuedInvoices/#{invoice_id}"
    JSON.parse response.body
  end

  def self.get_default
    response = Idoklad::ApiRequest.get '/developer/api/v2/IssuedInvoices/Default'
    JSON.parse response.body
  end

  def self.create(invoice)
    response = Idoklad::ApiRequest.post '/developer/api/v2/IssuedInvoices', invoice
    JSON.parse response.body
  end
end
