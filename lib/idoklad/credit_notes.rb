require 'active_support/core_ext/object/blank'
require 'json'
require 'pry'

class Idoklad::CreditNotes
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

    result = all_pages.flat_map { _1['Data']['Items'] }.map { Idoklad::CreditNote.new _1 }

    result
  end

  def self.get_credit_note(credit_note_id)
    response = Idoklad::ApiRequest.get "/CreditNotes/#{credit_note_id}"
    JSON.parse response.body
  end

  #
  # private

  def self.page filter = '', page_num = 1
    query = [filter, "page=#{page_num}"].select(&:present?).join '&'

    url = "/CreditNotes?#{query}"

    response = Idoklad::ApiRequest.get url
    parsed = JSON.parse response.body

    parsed
  end
end
