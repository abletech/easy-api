class TestController < ActionController::Base
  include Rails.application.routes.url_helpers
end

class UsersController < TestController
  include Easy::Api::ControllerMethods

  def index
    easy_api do |api|
      api.users = [User.new("bob", 25), User.new('sally',40)]
      api.success = true
      api.status_code = 200
      api.render_result(format: params[:format], callback: params[:callback])
    end
  end

  def show
    @result.user = User.new("bob", 25)
    @result.success = true
    @result.status_code = 200
    render_format
  end
end
