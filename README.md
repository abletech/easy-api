# Easy::Api

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

### Using Easy::Api::ControllerMethods
Add the following line to all Api Controllers:
  
    include Easy::Api::ControllerMethods

then in your Api actions, add values to the @result (Easy::Api::Result) object. 
If the request is a success, you must set 

     @result.status_code = true
     @result.success = true

and you can also set any other values you want to send back, e.g.

    @result.parcel = Parcel.first

If the request is unsuccessful, you must set the status_code, e.g.

    @result.status_code = 401

and you also need to set error to be an instance of Easy::Api::Error, e.g.

    @result.error = Easy::Api::Error.new(:unauthorized)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
