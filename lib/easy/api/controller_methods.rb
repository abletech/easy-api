# Include this module in all API controllers to get consistent responses
module Easy::Api::ControllerMethods
  module InstanceMethods

    # Initialises a new Easy::Api::Result object (@result) for your controller actions
    # takes a block
    def easy_api &block
      wrapper ||= Wrapper.new(self)
      yield(wrapper)
    end

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
      if render_params[:callback].blank?
        @controller.render(format => @result, :status => @result.status_code)
      else
        @controller.render(format => @result, :status => @result.status_code, :callback => render_params[:callback], :content_type => 'application/javascript')
      end
    end

    # Delegate other method calls to the result object
    def method_missing(name, *args, &block)
      @result.send(name, *args, &block)
    end

  end

  def self.included(base)
    base.send :include, InstanceMethods
  end
end
