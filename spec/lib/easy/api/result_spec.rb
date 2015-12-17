require 'spec_helper'
require 'json'

describe Easy::Api::Result do
  describe "#to_json" do
    let(:result) { Easy::Api::Result.new }
    subject(:parsed_json) { JSON.parse(result.to_json) }

    context "when result is unsuccessful" do
      let(:api_error) { Easy::Api::Error.new(:unauthorized) }

      before do
        result.error = api_error
      end

      it "contain the expected values" do
        expect(parsed_json).to eq({'success' => false, 'error' => {'code' => 401, 'message' => 'Unauthorized request'}})
      end
    end

    context "when result is successful" do

      before do
        result.success = true
        result.customer =  "Bob Loblaw"
      end

      it "has a success key" do
       expect(subject).to have_key('success')
      end

      it "is successful" do
        expect(subject['success']).to be(true)
      end

      it "has a customer key" do
       expect(subject).to have_key('customer')
      end

      it "has a customer name" do
       expect(subject['customer']).to eql "Bob Loblaw"
      end

      it "has no status code" do
        expect(subject).to_not have_key('status_code')
      end
    end
  end

  describe '#to_json' do
    let(:result) { Easy::Api::Result.new }

    subject(:parsed_json) { JSON.parse(result.to_json) }

    context 'with basic result attributes' do
      before do
        result.success = true
        result.customer =  "Bert O'Malley"
      end

      it "has a success key" do
       expect(parsed_json).to have_key('success')
      end

      it "is successful" do
        expect(parsed_json['success']).to be(true)
      end

      it "has a customer key" do
       expect(parsed_json).to have_key('customer')
      end

      it "has a customer name" do
       expect(parsed_json['customer']).to eql "Bert O'Malley"
      end
    end

    context 'with some RAW json attributes' do
      before do
        result.success = true
        result.raw.customer =  '{"'"name"'":"'"Geoff Flinders"'", "'"age"'":27, "'"height"'": 1.79}'
      end

      it "has a success key" do
       expect(parsed_json).to have_key('success')
      end

      it "is successful" do
        expect(parsed_json['success']).to be(true)
      end

      it "has a customer key" do
        expect(parsed_json).to have_key('customer')
      end

      it "has a customer name key" do
        expect(parsed_json['customer']).to have_key('name')
      end

      it "has a customer name value" do
        expect(parsed_json['customer']['name']).to eq('Geoff Flinders')
      end

      it "has a customer age key" do
        expect(parsed_json['customer']).to have_key('name')
      end

      it "has a customer age value" do
        expect(parsed_json['customer']['age']).to eq(27)
      end

      it "has a customer height key" do
        expect(parsed_json['customer']).to have_key('height')
      end

      it "has a customer height value" do
        expect(parsed_json['customer']['height']).to eq(1.79)
      end
    end
  end

  describe "#status_code" do
    let(:result) { Easy::Api::Result.new }
    subject { result.status_code }

    context "when it doesn't get set" do
      it "should throw an exception" do
        expect { subject }.to raise_error("Easy::Api::Result needs a status_code!")
      end
    end

    context "when it does get set" do
      before do
        result.status_code = 200
      end

      it "should reuturn the code" do
        expect(subject).to eql 200
      end
    end
  end

  describe "#to_xml" do
    let(:result) { Easy::Api::Result.new }
    subject(:parsed_xml) { Hash.from_xml(result.to_xml) }

    context "when result is unsuccessful" do
      let(:api_error) { Easy::Api::Error.new(:unauthorized) }

      before do
        result.error = api_error
      end

      it "includes the response.success value as false" do
        expect(parsed_xml).to have_key('response')
        expect(parsed_xml['response']).to have_key('success')
        expect(parsed_xml['response']['success']).to eq('false')
      end

      it "includes the response.error values" do
        expect(parsed_xml).to eq({'response' => {'success' => 'false', 'error' => {'code' => '401', "message"=>"Unauthorized request"}}})
      end
    end

    context "when result is successful" do
      before do
        result.success = true
        result.customer =  "Bob Loblaw"
      end

      it "renders the object as " do
       expect(parsed_xml).to eql({'response' => {'customer' => 'Bob Loblaw', 'success' => 'true'}})
      end
    end

    context "with some raw XML attributes" do
      before do
        result.success = true
        result.rating = 'SUPER DUPER'
        result.raw.customer =  "<name>Tristan</name><age>17</age><height>2.04</height>"
      end

      it 'should render the result including the RAW attributes' do
        expect(parsed_xml).to eq({'response' => {'success' => 'true', 'rating' => 'SUPER DUPER', 'customer' => {'name' => 'Tristan', 'age' => '17', 'height' => '2.04'}}})
      end
    end

    context 'with some nested attributes that match the root element name' do
      before do
        result.success = true
        result.response = 'Funny'
        result.raw.customer =  "<name>Charles</name>"
      end

      it 'should render the result including the RAW attributes' do
        expect(parsed_xml).to eq({'response' => {'success' => 'true', 'response' => 'Funny', 'customer' => {'name' => 'Charles'}}})
      end
    end
  end

end
