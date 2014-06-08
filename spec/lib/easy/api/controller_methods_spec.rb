require 'spec_helper'
require 'fixtures/application'
require 'fixtures/controllers'
require 'fixtures/models'
require 'rspec/rails'

describe UsersController, type: :controller do
  render_views
  describe '#index' do
    it "gets the index" do
      get :index, :format => 'json'
      expect(response.body).to eql("{\"users\":[{\"name\":\"bob\",\"age\":25},{\"name\":\"sally\",\"age\":40}],\"success\":true}")
    end
  end
end
