module Easy::Api
  class Error
    attr_reader :code, :message

    VALIDATION_ERROR = 400
    UNAUTHORIZED = 401
    NOT_FOUND = 404
    UNEXPECTED_ERROR = 500

    MESSAGES = {
      VALIDATION_ERROR => "Invalid request",
      UNAUTHORIZED => "This request requires a valid Private API Key",
      NOT_FOUND => "Resource not found",
      UNEXPECTED_ERROR => 'Sorry! An exception has occured. Please try again later',
    }

    def initialize(code, msg=nil)
      @code = code
      @message = msg || MESSAGES[code]
    end

    # do we need this method?
    def to_hash
      {:code => @code, :message => @message}
    end

    def as_json(options={})
      to_hash
    end
  end
end
