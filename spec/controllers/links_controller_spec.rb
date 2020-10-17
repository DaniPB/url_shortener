require 'rails_helper'

RSpec.describe LinksController, :type => :request do
  describe "POST create" do
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

  describe "GET show" do
    context "Right params" do
      it "create links" do
        link = create(:link, shortcut: "happy", visits: 3)

        get "/happy"

        expect(response.status).to eq(302)

        link.reload

        expect(response).to redirect_to(link.address)
        expect(link.visits).to eq(4)
      end
    end

    context "Bad params" do
      it "not create links" do
        get "/what"

        expect(response.status).to eq(400)

        response_body = JSON.parse(response.body)

        expected_response = {
          "message"=>"Link what not found",
          "location"=>{},
          "extra"=>{}
        }

        expect(response_body).to eq(expected_response)
      end
    end
  end
end
