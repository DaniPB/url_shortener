require 'rails_helper'

RSpec.describe Link, type: :model do
  it "is not valid with missing fields" do
    link = build(:link, address: nil, short: nil, visits: nil)

    expected_messages = {
      :address=>["can't be blank", "is invalid"],
      :short=>["can't be blank"],
      :visits=>["can't be blank"]
    }

    expect(link).to_not be_valid
    expect(link.errors.messages).to eq(expected_messages)
  end

  it "is not valid, short already exists" do
    create(:link, short: "H30ho32")
    link = build(:link, short: "H30ho32")

    expected_messages = {
      :short=>["has already been taken"]
    }

    expect(link).to_not be_valid
    expect(link.errors.messages).to eq(expected_messages)
  end

  it "is not valid, invalid address" do
    link = build(:link, address: "holi")

    expected_messages = {
      :address => ["is invalid"]
    }

    expect(link).to_not be_valid
    expect(link.errors.messages).to eq(expected_messages)
  end
end
