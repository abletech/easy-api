module Easy::Api::ControllerMethods

  def render_format
    respond_to do |format|
      format.html { render :status => @result.status_code }
      format.json { render :json => @result, :status => @result.status_code }
    end
  end

  private

  def setup_result
    @result = Result.new(success: false)
  end
end
