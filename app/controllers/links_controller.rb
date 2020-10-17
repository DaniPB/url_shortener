class LinksController < ApplicationController
  def create
    response = Links::Create::Execute.new.(create_params)

    if response.success?
      render json: response.success[:link], serializer: LinkSerializer
    else
      render json: response.failure, status: :bad_request
    end
  end

  private

  def create_params
    params.permit(:shortcut, :address).to_h.symbolize_keys
  end
end
