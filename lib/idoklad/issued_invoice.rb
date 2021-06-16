require 'vat_check'
require 'ostruct'

class Idoklad::IssuedInvoice < OpenStruct
  class Prices < OpenStruct
    class VatRateSummary < OpenStruct; end

    def vat_rate_summary
      self.VatRateSummary.map { VatRateSummary.new _1 }
    end
  end

  class Item < OpenStruct
    def prices
      Prices.new self.Prices
    end
  end

  class Customer < OpenStruct
    CZECH = 'Česká republika'
    SLOVAKIA = 'Slovenská republika'
    HUNGARY = 'Maďarská republika'
    ITALY = 'Italská republika'
    GREAT_BRITAIN = 'Velká Británie (před Brexitem)'
    GERMANY = 'Spolková republika Německo'
    POLAND = 'Polská republika'
    BELGIUM = 'Belgické království'
    EU_COUNTRIES = [SLOVAKIA, HUNGARY, ITALY, GERMANY, POLAND, BELGIUM]
    OTHER_COUNTRIES = [CZECH, GREAT_BRITAIN]
    COUNTRIES = EU_COUNTRIES + OTHER_COUNTRIES
    COUNTRY_CODES = { CZECH => 'CZ', SLOVAKIA => 'SK', HUNGARY => 'HU', ITALY => 'IT', GREAT_BRITAIN => 'GB', GERMANY => 'DE', POLAND => 'PL', BELGIUM => 'BE' }

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

      unless COUNTRIES.include? name
        fail "unknown country #{name} on contact #{self.Firstname} #{self.Surname}"
      end

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

  def prices
    Prices.new self.Prices
  end

  def my_address
    MyAddress.new self.MyAddress
  end

  def items
    self.Items.map { Item.new _1 }
  end
end
