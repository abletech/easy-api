# Include this module in all API controllers to get consistent responses
module Easy::Api::BlockWrapper
  module InstanceMethods

    # Initialises a new Easy::Api::Wrapper object takes a block of code to be rendered using the formatter
    def easy_api &block
      wrapper ||= Wrapper.new(self)
      yield(wrapper)
    end

  end

  def self.included(base)
    base.send :include, InstanceMethods
  end

  # A class to encapulate the API code so it can be called from the block.
  class Wrapper

    def initialize(controller)
      @controller = controller
      @result ||= Easy::Api::Result.new
    end

    # use the controller to render the response
    def render_result(render_params)
      format = (render_params[:format] || 'json').try(:to_sym)
      formatted_result = if format == :xml
        @result.to_xml(render_params[:options] || {})
      else
        @result
      end

      if render_params[:callback].present?
        @controller.render(format => formatted_result, :status => @result.status_code,
                          :callback => render_params[:callback], :content_type => 'application/javascript')
      elsif render_params[:template].present?
        @controller.instance_variable_set("@result", @result)
        @controller.render(render_params[:template], :status => @result.status_code)
      else
        @controller.render(format => formatted_result, :status => @result.status_code)
      end
    end

    # Delegate other method calls to the result object
    def method_missing(name, *args, &block)
      @result.send(name, *args, &block)
    end

  end

end
