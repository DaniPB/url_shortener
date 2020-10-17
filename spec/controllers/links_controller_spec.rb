require 'rails_helper'

RSpec.describe LinksController, :type => :request do
  describe "POST index" do
    let(:params) { { shortcut: 'happy', address: 'http://myaddress.com/something' } }

    context "Right params" do
      it "create links" do
        post '/links/', params: params

        expect(response.status).to eq(200)

        link = Link.last
        response_body = JSON.parse(response.body)
        new_address = "http://localhost:8080/#{params[:shortcut]}"

        expected_response = {
          "new_address"=>new_address,
          "visits"=>0
        }

        expect(response_body).to eq(expected_response)
        expect(Link.count).to eq(1)
        expect(link.address).to eq(params[:address])
        expect(link.shortcut).to eq(params[:shortcut])
        expect(link.new_address).to eq(new_address)
        expect(link.visits).to be_zero
      end
    end

    context "Bad params" do
      it "not create links" do
        params[:address] = "holi"

        post '/links/', params: params

        expect(response.status).to eq(400)

        response_body = JSON.parse(response.body)

        expected_response = {
          "message"=>"Creation failed",
          "location"=>{},
          "extra"=>{"address"=>["is invalid"]}
        }

        expect(response_body).to eq(expected_response)
        expect(Link.count).to be_zero
      end
    end
  end
end
