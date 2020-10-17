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
        new_address = "http://localhost:8080/l/#{params[:shortcut]}"

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
      it "show links" do
        link = create(:link, shortcut: "happy", visits: 3)

        get "/l/happy"

        expect(response.status).to eq(302)

        link.reload

        expect(response).to redirect_to(link.address)
        expect(link.visits).to eq(4)
      end
    end

    context "Bad params" do
      it "return an error" do
        get "/l/what"

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

  describe "GET index" do
    context "There are links" do
      it "list links" do
        link1 = create(:link, shortcut: "happy", visits: 1)
        link2 = create(:link, shortcut: "good", visits: 2)
        link3 = create(:link, shortcut: "perfect", visits: 3)

        get "/stats"

        expect(response.status).to eq(200)

        response_body = JSON.parse(response.body)

        expected_response = [
          {
            "new_address"=>link3.new_address,
            "visits"=>3
          },
          {
            "new_address"=>link2.new_address,
            "visits"=>2
          },
          {
            "new_address"=>link1.new_address,
            "visits"=>1
          }
        ]

        expect(response_body.count).to eq(3)
        expect(response_body).to eq(expected_response)
      end
    end

    context "There are no links" do
      it "return an error" do
        get "/stats"

        expect(response.status).to eq(400)

        response_body = JSON.parse(response.body)

        expected_response = {
          "message"=>"There are no links",
          "location"=>{},
          "extra"=>{}
        }

        expect(response_body).to eq(expected_response)
      end
    end
  end
end
