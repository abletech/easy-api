# Include this module in all API controllers to get consistent responses
module Easy::Api::ControllerMethods
  module InstanceMethods

    # Initialises a new Easy::Api::Result object (@result) for your controller actions
    # takes a block
    def easy_api
      @result ||= Easy::Api::Result.new
    end

    def render_result
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

    # Renders the Easy::Api::Result object in either json or html format (can be extended to include other formats)
    # def render_result(render_params)
    #   format = (render_params[:format] || 'json').try(:to_sym)
    #   if render_params[:callback].blank?
    #     @controller.render(format => @result, :status => @result.status_code)
    #   else
    #     @controller.render(format => @result, :status => @result.status_code, :callback => render_params[:callback], :content_type => 'application/javascript')
    #   end
    # end

  end

  def self.included(base)
    base.send :include, InstanceMethods
  end
end
