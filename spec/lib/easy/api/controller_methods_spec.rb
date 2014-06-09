require 'spec_helper'
require 'fixtures/application'
require 'fixtures/controllers'
require 'fixtures/models'
require 'rspec/rails'

describe UsersController, type: :controller do
  describe '#index' do
    it "gets the index in json format" do
      get :index, :format => 'json'
      expect(response.body).to eql("{\"users\":[{\"name\":\"bob\",\"age\":25},{\"name\":\"sally\",\"age\":40}],\"success\":true}")
    end

    it "gets the index in xml format" do
      get :index, :format => 'xml'
      expect(response.body).to eql("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<hash>\n  <users type=\"array\">\n    <user>\n      <name>bob</name>\n      <age>25</age>\n    </user>\n    <user>\n      <name>sally</name>\n      <age>40</age>\n    </user>\n  </users>\n  <success type=\"boolean\">true</success>\n</hash>\n")
    end
  end
end
