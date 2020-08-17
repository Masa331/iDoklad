require 'vat_check'
require 'ostruct'

class Idoklad::IssuedInvoice < OpenStruct
  class Item < OpenStruct
    class Prices < OpenStruct; end

    def prices
      Prices.new self.Prices
    end
  end

  class Customer < OpenStruct
    CZECH = 'Česká republika'
    EU_COUNTRIES = []
    OTHER_COUNTRIES = [CZECH]
    COUNTRIES = EU_COUNTRIES + OTHER_COUNTRIES
    COUNTRY_CODES = { CZECH => 'CZ' }

    def type
      if !czech? && country_eu? && valid_vatin?
        :eu_vat_payer
      else
        :other
      end
    end

    def czech?
      self.CountryName == CZECH
    end

    def country_eu?
      name = self.CountryName

      fail "unknown country #{name}" unless COUNTRIES.include? name

      EU_COUNTRIES.include? name
    end

    def valid_vatin?
      dic = self.VatIdentificationNumber
      full_dic =
        if dic.present?
          if dic[0..1].match?(/\D\D/)
            dic
          else
            "#{country_code}#{dic}"
          end
        end

       vat = VatCheck.new(full_dic)
       vat.exists?
    end

    def country_code
      COUNTRY_CODES.fetch self.CountryName
    end
  end

  class MyAddress < OpenStruct; end

  def customer
    Customer.new self.PartnerAddress
  end

  def my_address
    MyAddress.new self.MyAddress
  end

  def items
    self.Items.map { Item.new _1 }
  end
end
