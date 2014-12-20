require 'net/http'
require 'nokogiri'

class Pricer
  class UnknownPricingPolicy < StandardError; end

  def initialize(country_code, target_group_id, locations)
    @panel_provider = PanelProvider.
      includes(:countries).
      find_by(countries: {country_code: country_code})
  end

  def price
    if self.class.const_defined?(@panel_provider.code.camelcase)
      pricing_class = self.class.const_get(@panel_provider.code.camelcase)
      pricing_class.price
    else
      raise UnknownPricingPolicy, @panel_provider.code
    end
  end

  class Alpha
    URL = URI.parse('http://time.com')

    def self.price
      response = Net::HTTP.get(URL)
      response.count('a').to_f / 100
    end
  end

  class Beta
    URL = URI.parse('https://ajax.googleapis.com/ajax/services/feed/find?v=1.0&q=news')

    def self.price
      response = Net::HTTP.get(URL)
      # TODO: find a better way to count the number of occurrences of
      #       '<b>' in text
      "#{response}-solve end of stream counting issue".split(/<b>/).count - 1
    end
  end

  class Gamma
    URL = URI.parse('http://time.com')

    def self.price
      response = Net::HTTP.get(URL)
      nodes = Nokogiri.parse(response)
      nodes.css('*').count.to_f / 100
    end
  end
end
