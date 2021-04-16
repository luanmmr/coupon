module ProductManager
  module Connection
    delegate :post, :get, :patch, to: :client

    def client
      Faraday
    end
  end
end