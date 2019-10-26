module Idoklad
  API_URL = 'https://app.idoklad.cz'

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :client_id, :client_secret
  end
end

require_relative 'idoklad/contacts'
require_relative 'idoklad/countries'
require_relative 'idoklad/issued_invoices'
require_relative 'idoklad/auth'
require_relative 'idoklad/api_request'
