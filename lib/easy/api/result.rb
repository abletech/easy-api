require 'ostruct'

module Easy::Api
  class Result < OpenStruct

    def as_json
      hash = marshal_dump
      hash[:error] = hash[:error].as_json if hash[:error]
      hash
    end
  end
end
