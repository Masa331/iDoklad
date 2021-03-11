require 'active_support/core_ext/object/blank'
require 'json'
require 'pry'

class Idoklad::IssuedInvoices
  def self.get_list filter
    page filter
  end

  def self.all filter
    first_page = page filter
    total_pages = first_page['Data']['TotalPages']

    rest =
      if total_pages > 1
        (2..total_pages).map { page filter, _1 }
      else
        []
      end

    all_pages = [first_page] + rest

    result = all_pages.flat_map { _1['Data']['Items'] }.map { Idoklad::IssuedInvoice.new _1 }

    result
  end

  def self.get_invoice(invoice_id)
    response = Idoklad::ApiRequest.get "/IssuedInvoices/#{invoice_id}"
    JSON.parse response.body
  end

  def self.get_default
    response = Idoklad::ApiRequest.get '/IssuedInvoices/Default'
    JSON.parse response.body
  end

  def self.create(invoice)
    response = Idoklad::ApiRequest.post '/IssuedInvoices', invoice
    JSON.parse response.body
  end
  #
  # private

  def self.page filter = '', page_num = 1
    query = [filter, "page=#{page_num}"].select(&:present?).join '&'

    url = "/IssuedInvoices?#{query}"

    response = Idoklad::ApiRequest.get url
    parsed = JSON.parse response.body

    parsed
  end
end
