require 'rails_helper'

RSpec.describe LinkSerializer do
  let(:link)          { build(:link) }
  let(:serializer)    { described_class.new(link) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  let(:subject) { JSON.parse(serialization.to_json) }

  context "The link is ok" do
    it "Should return a hash" do

      expected_response = {
        "new_address"=>link.new_address,
        "visits"=>link.visits
      }

      expect(subject).to match(expected_response)
    end
  end
end
