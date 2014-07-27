require 'spec_helper'

RSpec.describe Easy::Api::Result do
  RSpec.describe "#as_json" do
    let(:result) { Easy::Api::Result.new }
    subject { result.as_json }

    context "when result is unsuccessful" do
      let(:api_error) { Easy::Api::Error.new(:unauthorized) }

      before do
        result.error = api_error
      end

      it "has a success key" do
       expect(subject).to have_key(:success)
      end

      it "is not successful" do
        expect(subject[:success]).to be(false)
      end

      it "has no status code" do
        expect(subject).to_not have_key(:status_code)
      end

      it "has an error" do
       expect(subject).to have_key(:error)
      end

      context "json error" do
        subject { result.as_json[:error] }

        it "has an error" do
         expect(subject.code).to eql api_error.code
        end

        it "has an error code" do
          expect(subject.message).to eql api_error.message
        end

      end
    end

    context "when result is successful" do

      before do
        result.success = true
        result.customer =  "Bob Loblaw"
      end

      it "has a success key" do
       expect(subject).to have_key(:success)
      end

      it "is successful" do
        expect(subject[:success]).to be(true)
      end

      it "has a customer key" do
       expect(subject).to have_key(:customer)
      end

      it "has a customer name" do
       expect(subject[:customer]).to eql "Bob Loblaw"
      end

      it "has no status code" do
        expect(subject).to_not have_key(:status_code)
      end

    end

  end

  RSpec.describe "#status_code" do
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
end
