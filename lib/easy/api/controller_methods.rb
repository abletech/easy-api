# Include this module in all API controllers to get consistent responses
module Easy::Api::ControllerMethods
  module InstanceMethods
    # Renders the Easy::Api::Result object in either json or html format (can be extended to include other formats)
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
end
