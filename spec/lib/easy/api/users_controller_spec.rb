require 'spec_helper'
require 'fixtures/application'
require 'fixtures/controllers'
require 'fixtures/models'
require 'rspec/rails'

RSpec.describe UsersController, :type => :controller do
  context 'depricated render_format method' do

    context 'GET #index' do

      it "gets the index in json format" do
        get :index, :format => 'json'

        parsed_response = MultiJson.load(response.body)
        expect(parsed_response['users'].size).to eq(2)

        user_names = parsed_response['users'].collect{|c| c['name']}
        expect(user_names).to include('bob')
        expect(user_names).to include('sally')

        user_ages = parsed_response['users'].collect{|c| c['age']}
        expect(user_ages).to include(25)
        expect(user_ages).to include(40)

        expect(parsed_response['success']).to eq(true)
      end

      it "gets the index in xml format" do
        get :index, :format => 'xml'
        expect(response.body).to eql("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<response>\n  <users>\n    <user>\n      <name>bob</name>\n      <age>25</age>\n    </user>\n    <user>\n      <name>sally</name>\n      <age>40</age>\n    </user>\n  </users>\n  <success>true</success>\n</response>\n")
      end
    end

    context 'GET #show' do
      it "gets show in json format" do
        get :show, :format => 'json', id: 1

        parsed_response = MultiJson.load(response.body)
        expect(parsed_response['user']).to_not be(nil)
        expect(parsed_response['user']['name']).to eq('bob')
        expect(parsed_response['user']['age']).to eq(25)
        expect(parsed_response['success']).to eq(true)
      end

      it "gets show in xml format" do
        get :show, :format => 'xml', id: 1
        expect(response.body).to eql("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<response>\n  <user>\n    <name>bob</name>\n    <age>25</age>\n  </user>\n  <success>true</success>\n</response>\n")
      end

    end

  end

end
