require 'ostruct'

class Idoklad::IssuedInvoice < OpenStruct
  class Item < OpenStruct
  end

  class Customer < OpenStruct
  end

  def customer
    Customer.new self.PartnerAddress
  end

  def items
    self.Items.map { Item.new _1 }
  end
end
