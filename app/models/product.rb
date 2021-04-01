class Product
  attr_accessor :id, :key

  class << self
    def host
      Rails.configuration.apis_servers[:product_url]
    end

    def api_version
      'v1'
    end

    def product_url
      url = "#{host}/api/#{api_version}/product_types"
      response = Faraday.get(url)
      JSON.parse(response.body, symbolize_names: true)
    end

    def all
      products = product_url

      products.map do |product|
        Product.new(id: product[:id], key: product[:product_key])
      end
    end

    def find(id)
      all.detect { |product| product.id == id}
    end
  end

  def initialize(id:, key:)
    self.id = id
    self.key = key
  end
end