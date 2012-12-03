# Include this module in all API controllers to get consistent responses
module Easy::Api::ControllerMethods
  module InstanceMethods
    # Renders the Easy::Api::Result object in either json or html format (can be extended to include other formats)
    def render_format
      respond_to do |format|
        format.html { render :status => @result.status_code }
        format.xml  { render :xml => @result.to_xml(:root => 'response', :skip_types => true), :status => @result.status_code }
        format.json { render :json => @result, :status => (params[:callback].present? ? 200 : @result.status_code), :callback => params[:callback] }
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
