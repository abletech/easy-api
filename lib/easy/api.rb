require 'easy/api/version'
require 'easy/api/controller_methods'
require 'easy/api/block_wrapper'
require 'easy/api/result'
require 'easy/api/error'

module Easy::Api
  def self.included(base)
    base.send :include, Easy::Api::BlockWrapper
  end
end
