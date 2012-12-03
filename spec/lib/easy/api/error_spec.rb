require 'spec_helper'

describe Easy::Api::Error do
  describe ".new" do
    subject { Easy::Api::Error.new(:invalid, message) }

    context "when a message is passed in" do
      let(:message) { "Hello, world!" }
      its(:message) { should == message }
    end

    context "when no message is passed in" do
      let(:message) { nil }
      its(:message) { should == Easy::Api::Error.messages[:invalid] }
    end
  end

  describe "#as_json" do
    subject { Easy::Api::Error.new(:unexpected, msg).as_json }
    let(:msg) { 'uh, oh' }

    its([:code]) { should == Easy::Api::Error.codes[:unexpected] }
    its([:message]) { should == msg }
  end
end
