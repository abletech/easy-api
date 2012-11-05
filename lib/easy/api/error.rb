module Easy::Api
  # Encapsulates the types of errors that API calls can respond with
  class Error
    attr_reader :code, :message

    CODES = {
      invalid: 400,
      unauthorized: 401,
      not_found: 404,
      unexpected: 500
    }

    MESSAGES = {
      invalid: "Invalid request",
      unauthorized: "This request requires a valid Private API Key",
      not_found: "Resource not found",
      unexpected: 'Sorry! An exception has occured. Please try again later',
    }

    # Initializes a new error based on the type, with an optional custom message
    #
    # @param [Symbol] type can be :invalid, :unauthorized, :not_found, or :unexpected
    # @param [optional, String] msg a custom error message (see MESSAGES for default message values)
    def initialize(type, msg=nil)
      @code = CODES[type]
      @message = msg || MESSAGES[type]
    end

    # Returns the error as a hash
    #
    # @return [Hash] a hash containing the error code and message
    def to_hash
      {:code => @code, :message => @message}
    end

    # Used by Rails to parse the error as json
    #
    # @return [Hash] a hash containing the error code and message
    def as_json(options={})
      to_hash
    end
  end
end
