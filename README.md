# Easy::Api

[<img src="https://travis-ci.org/AbleTech/easy-api.png" />](https://travis-ci.org/AbleTech/easy-api)

A repository of common, reusable API code. Its purpose is to make all of Abletech's APIs respond in a consistent manner.

## Installation

Add this line to your application's Gemfile:

    gem 'easy-api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy-api

## Usage

Easy-api consists of a module to be included in your Api Controller, as well as classes to encapsulate API Errors and API Results.

### Using Easy::Api::Error

This class encapsulates the different failure responses that can be returned from our APIs. The four types of errors are: invalid, unauthorized, not_found, and unexpected.

To initialise an error, pass in the type you want, e.g.

    Easy::Api::Error.new(:unauthorized)

If you want to override the default error message, pass in a custom message, e.g.

    Easy::Api::Error.new(:invalid, @user.errors.full_messages.join(', '))

Easy::Api::Error objects have a code (e.g. 404) and a message (e.g. 'Resource not found')

You can also define you own error types. Add the following to `initializers/easy_api.rb`

    Easy::Api::Error.codes[:rate_limited] = 429
    Easy::Api::Error.messages[:rate_limited] = 'Rate limited'

### Using Easy::Api

Add the following line to all Api Controllers:

    include Easy::Api

Then in your Api actions, do your logic inside a block:

     easy_api do |api|
        api.parcel = Parcel.first
        api.status_code = 200
        api.success = true
        api.render_result(format: params[:format])
     end

If the request is a success, you must set

     api.status_code = 200
     api.success = true

and you can also set any other values you want to send back, e.g.

    api.parcel = Parcel.first

If the request is unsuccessful, you must set the status_code, e.g.

    api.status_code = 401

and you also need to set error to be an instance of Easy::Api::Error, e.g.

    api.error = Easy::Api::Error.new(:unauthorized)

Then render the result

     api.render_result(format: params[:format])

### Support for JSONP

If your API supports callbacks (JSONP) these can also be passed. The returned content_type header will change to `application/javascript` in this case.

     api.render_result(format: params[:format], callback: params[:callback])

## Support for externally generated JSON and XML

Sometimes it makes sense to use your database to generate the raw JSON or XML. If
you need to do this, you can use the raw method as shown below.

    easy_api do |api|
       api.status_code = 200
       api.success = true
       api.year = 2015
       api.raw.animals = '[{"name" => "Charles Bird"}, {"name" => "Silver"}, {"name" => "Lassie"}]'

       api.render_result(format: params[:format])
    end

or support both JSON and XML:

    easy_api do |api|
       api.status_code = 200
       api.success = true
       api.enterprise = 'safe'

       if params[:format] == 'xml'
         api.raw.categories = '<category>Large</category><category>Medium</category><category>Small</category>'
       else
         api.raw.categories = '["Large", "Medium", "Small"]'
       end

       api.render_result(format: params[:format])
    end


### Using Easy::Api::ControllerMethods

**Deprecated**

Add the following line to all Api Controllers:

    include Easy::Api::ControllerMethods

then in your Api actions, add values to the @result (Easy::Api::Result) object.
If the request is a success, you must set

     @result.status_code = 200
     @result.success = true

and you can also set any other values you want to send back, e.g.

    @result.parcel = Parcel.first

If the request is unsuccessful, you must set the status_code, e.g.

    @result.status_code = 401

and you also need to set error to be an instance of Easy::Api::Error, e.g.

    @result.error = Easy::Api::Error.new(:unauthorized)

Then render the result

    render_format

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
