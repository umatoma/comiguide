class Api::V1::CareasController < Api::V1::BaseController
  skip_before_action :authenticate_user_from_api_token

  def index
    @careas = Carea.includes(:cblocks).all
  end
end
