require 'spec_helper'

describe Easy::Api::Result do
  describe "#as_json" do
    let(:result) { Easy::Api::Result.new }
    subject { result.as_json }

    context "when result is unsuccessful" do
      let(:api_error) { Easy::Api::Error.new(:unauthorized) }
      
      before do
        result.error = api_error
      end

      it { should have_key :success }
      its([:success]) { should be_false }
      it { should_not have_key :status_code }
      
      it { should have_key :error }

      context "[:error]" do
        subject { result.as_json[:error] }
        its(:code) { should == api_error.code }
        its(:message) { should == api_error.message }
      end
    end

    context "when result is successful" do
      before do
        result.success = true
        result.customer =  "Bob Loblaw"
      end

      it { should have_key :success }
      its([:success]) { should be_true }

      it { should have_key :customer }
      its([:customer]) { should == "Bob Loblaw" }
      it { should_not have_key :status_code }
    end

  end

  describe "#status_code" do
    let(:result) { Easy::Api::Result.new }
    subject { result.status_code }
    
    context "when it doesn't get set" do
      it "should throw an exception" do
        lambda { subject }.should raise_error "Easy::Api::Result needs a status_code!"
      end
    end

    context "when it does get set" do
      before do
        result.status_code = 200
      end
      it { should == 200 }
    end
  end
end
