class TestController < ActionController::Base
  include Rails.application.routes.url_helpers
end

class UsersController < TestController
  include Easy::Api::ControllerMethods

  def index
    @result.users = [User.new("bob", 25), User.new('sally',40)]
    @result.success = true
    @result.status_code = 200
    render_format
  end

  def show
    @result.user = User.new("bob", 25)
    @result.success = true
    @result.status_code = 200
    render_format
  end
end

class CustomersController < TestController
  include Easy::Api

  def index
    easy_api do |api|
      api.customers = [Customer.new("fred", 19), Customer.new('jackie',21)]
      api.success = true
      api.status_code = 200
      api.render_result(format: params[:format], callback: params[:callback])
    end
  end

  def show
    easy_api do |api|
      api.customer = Customer.new("fred", 21)
      api.success = true
      api.status_code = 200
      api.render_result(format: params[:format], callback: params[:callback])
    end
  end
end
