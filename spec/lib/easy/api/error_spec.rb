require 'spec_helper'

describe Easy::Api::Error do
  describe ".new" do
    subject { Easy::Api::Error.new(:invalid, message) }

    context "when a message is passed in" do
      let(:message) { "Hello, world!" }

      it "has sets the message" do
        expect(subject.message).to eql message
      end
    end

    context "when no message is passed in" do
      let(:message) { nil }

      it "the message is invalid" do
        expect(subject.message).to eql Easy::Api::Error.messages[:invalid]
      end
    end
  end

  describe "#as_json" do
    subject { Easy::Api::Error.new(:unexpected, message).as_json }
    let(:message) { 'uh, oh' }

    it "the code is returned" do
      expect(subject[:code]).to eql Easy::Api::Error.codes[:unexpected]
    end

    it "the message is returned" do
      expect(subject[:message]).to eql message
    end
  end

  describe "#errors" do
    it "should allow the Easy::Api:Error.codes to be altered" do
      Easy::Api::Error.codes[:new_error] = 1010
      expect(Easy::Api::Error.codes[:new_error]).to eq(1010)
    end
  end

  describe "#messages" do
    it "should allow the Easy::Api:Error.messages to be altered" do
      Easy::Api::Error.messages[:new_error] = 'I am new'
      expect(Easy::Api::Error.messages[:new_error]).to eq('I am new')
    end
  end
end
