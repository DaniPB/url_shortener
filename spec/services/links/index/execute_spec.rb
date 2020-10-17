require 'rails_helper'

RSpec.describe Links::Index::Execute do
  describe "#call" do
    let(:response)  { subject.() }

    context "There are links" do
      it "Should return the Links" do
        link1 = create(:link, shortcut: "happy", visits: 1)
        link2 = create(:link, shortcut: "good", visits: 2)
        link3 = create(:link, shortcut: "perfect", visits: 3)

        expected_response = [ link3, link2, link1 ]

        expect(response).to be_success
        expect(response.success).to eq(expected_response)
      end
    end

    context "There are links" do
      it "Should return an error" do
        expected_response = {
          :message=>"There are no links",
          :location=>Links::Index::Execute,
          :extra=>{}
        }

        expect(response).to be_failure
        expect(response.failure).to eq(expected_response)
      end
    end
  end
end
