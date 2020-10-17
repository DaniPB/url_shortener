require 'rails_helper'

RSpec.describe Errors do
  let(:subject)  { described_class }
  let(:status)   { :success }
  let(:message)  { "this is a message"}
  let(:location) { self.class }


  describe "#general_error" do
    it "Should return a hash" do
      response = subject.general_error(status, self.location, { error: "algo falllaa" })
      expected_response = { message: status, location: location, extra: { error: "algo falllaa" } }

      expect(response).to eq(expected_response)
    end
  end

  describe "#model_error" do
    it "Should return a hash" do
      response = subject.model_error(status, message, { error: "algo falllaa" })
      expected_response = { message: status, model: message, extra: { error: "algo falllaa" } }

      expect(response).to eq(expected_response)
    end
  end
end
