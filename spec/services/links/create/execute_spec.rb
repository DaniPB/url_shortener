require 'rails_helper'

RSpec.describe Links::Create::Execute do
  describe "#call" do
    let(:response)  { subject.call(input) }
    let(:input)     { {
      shortcut: 'happy',
      address: 'https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally'
    } }

    context "Shortcut is in params" do
      it "Should create a Link with the input short" do
        expect(response).to be_success

        link = Link.last

        expected_response = {
          link: link
        }

        expect(response.success).to eq(expected_response)
        expect(Link.count).to eq(1)
        expect(link.address).to eq(input[:address])
        expect(link.shortcut).to eq(input[:shortcut])
        expect(link.visits).to be_zero
      end
    end

    context "Shortcut is not in params" do
      it "Should create a Link with the input short" do
        input.delete(:shortcut)

        expect(SecureRandom).to receive(:alphanumeric).and_return("RandomHa10")

        expect(response).to be_success

        link = Link.last

        expected_response = {
          link: link
        }

        expect(response.success).to eq(expected_response)
        expect(Link.count).to eq(1)
        expect(link.address).to eq(input[:address])
        expect(link.shortcut).to eq("RandomHa10")
        expect(link.visits).to be_zero
      end
    end

    context "Invalid address" do
      it "Should return an error" do
        input[:address] = "holii"

        expected_response = {
          :message=>"Creation failed",
          :model=>Link,
          :extra=>{:address=>["is invalid"]}
        }

        expect(response).to be_failure
        expect(response.failure).to eq(expected_response)
        expect(Link.count).to eq(0)
      end
    end

    context "Link already exists" do
      it "Should return an error" do
        create(:link, shortcut: "happy")

        expected_response = {
          :message=>"Creation failed",
          :model=>Link,
          :extra=>{:shortcut=>["has already been taken"]}
        }

        expect(response).to be_failure
        expect(response.failure).to eq(expected_response)
        expect(Link.count).to eq(1)
      end
    end

    context "Input validation fails" do
      it "Should return an error" do
        input[:shortcut] = 123
        input[:address] = 123

        expected_response = {
          :message=>"Validation failed",
          :location=>Links::Create::Execute,
          :extra=>{:address=>["must be a string"], :shortcut=>["must be a string"]}
        }

        expect(response).to be_failure
        expect(response.failure).to eq(expected_response)
        expect(Link.count).to eq(0)
      end
    end
  end
end
