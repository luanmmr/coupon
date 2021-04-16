module ProductManager
  class Client
    include Connection

    def initialize(url: ENV.fetch('PRODUCT_MANAGER_SERVER'))
      @server = url
    end

    def find(product_id)
      response = get(find_product_url(product_id))
      mount_product(parse(response))
    rescue Faraday::Error => error
      raise ProductManager::ErrorBuilder.build(error)
    end

    def all
      response = get(all_products_url)
      parse(response).map do |product_hash|
        mount_product(product_hash)
      end
    rescue Faraday::Error => error
      raise ProductManager::ErrorBuilder.build(error)
    end

    private

    def mount_product(params_hash)
      ProductManager::Models::Product.new(params_hash)
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end

    def find_product_url(product_id)
      URI.join(@server, "api/v1/product_types/#{product_id}")
    end

    def all_products_url
      URI.join(@server, "api/v1/product_types")
    end
  end
end

