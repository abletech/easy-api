require 'spec_helper'
require 'fixtures/application'
require 'fixtures/controllers'
require 'fixtures/models'
require 'rspec/rails'

RSpec.describe CustomersController, :type => :controller do

  context 'GET #index' do

    it "gets the index in json format" do
      get :index, :format => 'json'
      expect(response.body).to eql("{\"customers\":[{\"name\":\"fred\",\"age\":19},{\"name\":\"jackie\",\"age\":21}],\"success\":true}")
    end

    it "gets the index in xml format" do
      get :index, :format => 'xml'
      expect(response.body).to eql("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<hash>\n  <customers type=\"array\">\n    <customer>\n      <name>fred</name>\n      <age>19</age>\n    </customer>\n    <customer>\n      <name>jackie</name>\n      <age>21</age>\n    </customer>\n  </customers>\n  <success type=\"boolean\">true</success>\n</hash>\n")
    end

  end

  context 'GET #show' do

    it "gets show in json format" do
      get :show, :format => 'json', id: 1
      expect(response.body).to eql("{\"customer\":{\"name\":\"fred\",\"age\":21},\"success\":true}")
    end

    it "gets show in xml format" do
      get :show, :format => 'xml', id: 1
      expect(response.body).to eql("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<hash>\n  <customer>\n    <name>fred</name>\n    <age>21</age>\n  </customer>\n  <success type=\"boolean\">true</success>\n</hash>\n")
    end

  end

end
