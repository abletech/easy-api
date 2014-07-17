# Include this module in all API controllers to get consistent responses
module Easy::Api::ControllerMethods
  module InstanceMethods

    # Initialises a new Easy::Api::Wrapper object takes a block of code to be rendered using the formatter
    def easy_api &block
      wrapper ||= Wrapper.new(self)
      yield(wrapper)
    end

    # Renders the Easy::Api::Result object in either json or html format (can be extended to include other formats)
    # @deprecated Use {#Wrapper.render_result} instead
    def render_format
      respond_to do |format|
        format.html do
          render :status => @result.status_code
        end

        format.xml do
          render :xml => @result.to_xml(:root => 'response', :skip_types => true), :status => @result.status_code
        end

        format.json do
          if params[:callback].present?
            status = 200
            content_type = 'application/javascript'
          else
            status = @result.status_code
            content_type = 'application/json'
          end

          render :json => @result, :status => status, :callback => params[:callback], :content_type => content_type
        end
      end
    end

    # Initialises a new Easy::Api::Result object (@result) for your controller actions
    # @return Easy::Api::Result
    def setup_result
      @result = Easy::Api::Result.new
    end

  end

  def self.included(base)
    base.send :include, InstanceMethods

    # ensure setup_result happens before any other before_filters
    base.prepend_before_filter :setup_result
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

end
