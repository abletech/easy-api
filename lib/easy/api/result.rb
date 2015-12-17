require 'ostruct'
require "active_support/core_ext/hash/conversions"

module Easy::Api
  # Encapsulates the response data of an API call
  #
  # Expected values to be added are:
  # #status_code
  # success
  # error (see Easy::Api::Error#new)
  class Result

    attr_writer :success, :status_code, :error

    def initialize
      @native_attributes = {}
    end

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

    def raw
      @raw ||= RawAttributesResult.new
    end

    # # Used by Rails to render the result as json
    # #
    # # Will always contain 'success', the error if there is one, and any dynamic attributes.
    # # @return [Hash]
    # def as_json(options={})
    #   non_raw_attributes
    # end

    def to_json(options={})
      json = non_raw_attributes.to_json

      if raw.attributes.any?
        json = json.chop # remove the closing '}'

        raw.attributes.each_with_index do |(attr_name, raw_value), index|
          json << ','

          json << '"' << attr_name << '":' << raw_value
        end

        json << '}'
      end

      json
    end

    # Used by Rails to parse the result as xml
    #
    # Will always contain 'success', the error if there is one, and any dynamic attributes.
    # @return [Hash]
    def to_xml(options={})
      options = options.dup
      options[:root]        ||= 'response'
      options[:skip_types]  ||= true

      xml = non_raw_attributes.to_xml(options)

      if raw.attributes.any?
        xml.gsub!(/<\/#{options[:root]}>[\s\n]*\z/, '') # remove the closing </response>

        raw.attributes.each_with_index do |(attr_name, raw_value), index|
          xml << '<' << attr_name << '>' << raw_value << '</' << attr_name << '>'
        end

        xml << "</#{options[:root]}>"
      end

      xml
    end

    def method_missing(symbol, *args)
      if symbol =~ /.+=/
        attr_name = symbol.to_s[0..-2]
        @native_attributes[attr_name] = args.first
      else
        super
      end
    end

    private

    def non_raw_attributes
      hash = @native_attributes.merge('success' => success)

      if error
        hash['error'] = error.as_json
      end

      hash
    end
  end

  class RawAttributesResult
    def initialize
      @attributes = {}
    end

    attr_reader :attributes

    def method_missing(symbol, *args)
      if symbol =~ /.+=/
        attr_name = symbol.to_s[0..-2]
        @attributes[attr_name] = args.first
      else
        super
      end
    end
  end
end
