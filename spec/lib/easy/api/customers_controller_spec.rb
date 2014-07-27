require 'spec_helper'
require 'fixtures/application'
require 'fixtures/controllers'
require 'fixtures/models'
require 'rspec/rails'
require 'multi_json'

RSpec.describe CustomersController, :type => :controller do

  context 'GET #index' do

    it "gets the index in json format" do
      get :index, :format => 'json'

      parsed_response = MultiJson.load(response.body)
      expect(parsed_response['customers'].size).to eq(2)

      customer_names = parsed_response['customers'].collect{|c| c['name']}
      expect(customer_names).to include('fred')
      expect(customer_names).to include('jackie')

      customer_ages = parsed_response['customers'].collect{|c| c['age']}
      expect(customer_ages).to include(19)
      expect(customer_ages).to include(21)

      expect(parsed_response['success']).to eq(true)
    end

    it "gets the index in xml format" do
      get :index, :format => 'xml'
      expect(response.body).to eql("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<hash>\n  <customers type=\"array\">\n    <customer>\n      <name>fred</name>\n      <age>19</age>\n    </customer>\n    <customer>\n      <name>jackie</name>\n      <age>21</age>\n    </customer>\n  </customers>\n  <success type=\"boolean\">true</success>\n</hash>\n")
    end

  end

  context 'GET #show' do

    it "gets show in json format" do
      get :show, :format => 'json', id: 1

      parsed_response = MultiJson.load(response.body)
      expect(parsed_response['customer']).to_not be(nil)
      expect(parsed_response['customer']['name']).to eq('fred')
      expect(parsed_response['customer']['age']).to eq(21)
      expect(parsed_response['success']).to eq(true)
    end

    it "gets show in xml format" do
      get :show, :format => 'xml', id: 1
      expect(response.body).to eql("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<hash>\n  <customer>\n    <name>fred</name>\n    <age>21</age>\n  </customer>\n  <success type=\"boolean\">true</success>\n</hash>\n")
    end

  end

end
