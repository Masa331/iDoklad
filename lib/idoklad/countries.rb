require 'json'
class Idoklad::Countries
  def self.get_list
    first_page = get_list_page
    total_pages = first_page['TotalPages']

    all_pages =
    if total_pages > 1
      other_pages = (2..total_pages).map { |page_number| get_list_page(page_number) }
      [first_page] + other_pages
    else
      [first_page]
    end

    all_pages.flat_map { |page| page['Data'] }
  end

  private

  def self.get_list_page(page = 1)
    response = Idoklad::ApiRequest.get "/developer/api/v2/Countries?Page=#{page}"
    JSON.parse response.body
  end
end
