module ProductManager
  module Models
    class Product < Dry::Struct
      attribute :id, Types::Strict::Integer
      attribute :product_key, Types::Strict::String
      attribute :name, Types::Strict::String
      attribute :description, Types::Strict::String
    end
  end
end