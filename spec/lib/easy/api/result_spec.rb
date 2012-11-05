require 'spec_helper'

describe Easy::Api::Result do
  describe "#as_json" do
    subject { Easy::Api::Result.new(params).as_json }

    context "when result is unsuccessful" do
      let(:params) { {success: false, error: Easy::Api::Error.new(401)} }

      it { should have_key :success }
      its([:success]) { should be_false }
      
      it { should have_key :error }
      its([:error]) { should have_key :code }
      its([:error]) { should have_key :message }
    end

    context "when result is successful" do
      let(:params) { {success: true, customer: "Bob Loblaw"} }

      it { should have_key :success }
      its([:success]) { should be_true }

      it { should have_key :customer }
      its([:customer]) { should == "Bob Loblaw" }
    end
  end
end
