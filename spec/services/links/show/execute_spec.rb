require 'rails_helper'

RSpec.describe Links::Show::Execute do
  describe "#call" do
    let(:response)  { subject.call(input) }
    let(:input)     { {
      shortcut: 'happy',
    } }

    context "Link exists" do
      it "Should return the Link" do
        link = create(:link, shortcut: "happy")

        expected_response = {
          link: link
        }

        expect(response).to be_success
        expect(response.success).to eq(expected_response)
      end
    end

    context "Link doesn't exists" do
      it "Should return the Link" do
        link = create(:link, shortcut: "sad")

        expected_response = {
          :message=>"Link happy not found",
          :location=>Links::Show::Execute,
          :extra=>{}
        }

        expect(response).to be_failure
        expect(response.failure).to eq(expected_response)
      end
    end

    context "Input validation fails, wrong input types" do
      it "Should return an error" do
        input[:shortcut] = 123

        expected_response = {
          :message=>"Validation failed",
          :location=>Links::Show::Execute,
          :extra=>{:shortcut=>["must be a string"]}
        }

        expect(response).to be_failure
        expect(response.failure).to eq(expected_response)
      end
    end

    context "Input validation fails, missing shortcut" do
      it "Should return an error" do
        input.delete(:shortcut)

        expected_response = {
          :message=>"Validation failed",
          :location=>Links::Show::Execute,
          :extra=>{:shortcut=>["is missing"]}
        }

        expect(response).to be_failure
        expect(response.failure).to eq(expected_response)
      end
    end
  end
end
