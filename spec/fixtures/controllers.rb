class TestController < ActionController::Base
  include Rails.application.routes.url_helpers
end

class UsersController < TestController
  include Easy::Api::ControllerMethods

  def index
    easy_api.users = [User.new("bob", 25), User.new('sally',40)]
    easy_api.success = true
    easy_api.status_code = 200
    render_result
  end
end
