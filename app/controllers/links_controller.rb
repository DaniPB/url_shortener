class LinksController < ApplicationController
  def create
    response = Links::Create::Execute.new.(create_params)

    if response.success?
      render json: response.success[:link], serializer: LinkSerializer
    else
      render json: response.failure, status: :bad_request
    end
  end

  def show
    response = Links::Show::Execute.new.(show_params)

    if response.success?
      address = response.success[:link].address

      redirect_to address
    else
      render json: response.failure, status: :bad_request
    end
  end

  private

  def create_params
    params.permit(:shortcut, :address).to_h.symbolize_keys
  end

  def show_params
    params.permit(:shortcut).to_h.symbolize_keys
  end
end
