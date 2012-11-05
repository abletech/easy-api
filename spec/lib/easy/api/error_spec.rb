require 'spec_helper'

describe Easy::Api::Error do
  describe ".new" do
    subject { Easy::Api::Error.new(code, message) }

    context "when a message is passed in" do
      let(:code) { 400 }
      let(:message) { "Hello, world!" }
      its(:message) { should == message }
    end

    context "when no message is passed in" do
      let(:code) { 400 }
      let(:message) { nil }
      its(:message) { should == Easy::Api::Error::MESSAGES[code] }
    end
  end

  describe "#as_json" do
    subject { Easy::Api::Error.new(code, msg).as_json }
    let(:code) { 500 }
    let(:msg) { 'uh, oh' }

    its([:code]) { should == code }
    its([:message]) { should == msg }
  end
end
