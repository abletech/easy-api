require 'ostruct'

module Easy::Api
  # Encapsulates the response data of an API call
  #
  # Expected values to be added are:
  # #status_code
  # success
  # error (see Easy::Api::Error#new)
  class Result < OpenStruct
    attr_writer :success, :status_code, :error

    # An instance of Easy::Api::Error or nil if there is no error
    # @return [Easy::Api::Error, nil]
    def error
      @error
    end

    # Represents whether the request succeeded or not
    # @return [true, false]
    def success
      @success || false
    end

    # The HTTP status code to respond with
    # @raise StandardError if status_code has not been set
    # @return [Integer] status_code (e.g. 200, 400, 500)
    def status_code
      @status_code || raise("Easy::Api::Result needs a status_code!")
    end

    # Used by Rails to render the result as json
    #
    # Will always contain 'success', the error if there is one, and any dynamic attributes.
    # @return [Hash]
    def as_json(options={})
      hash = marshal_dump.merge(success: success)
      hash[:error] = error unless error.nil?
      hash
    end
  end
end
