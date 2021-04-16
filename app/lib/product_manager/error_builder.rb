module ProductManager
  class Error < StandardError; end
  class ConnectionFailed < Error; end

  class ErrorBuilder
    class << self
      def build(product_error)
        error_message = product_error.message

        case error_message
        when /Failed to open TCP connection/
          ConnectionFailed.new(error_message)
        else
          Error.new(error_message)
        end
      end
    end
  end
end