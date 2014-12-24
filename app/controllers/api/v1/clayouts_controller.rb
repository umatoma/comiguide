class Api::V1::ClayoutsController < Api::V1::BaseController
  skip_before_action :authenticate_user_from_api_token

  def index
    @cblock = Cblock.find(params[:cblock_id])
    @clayouts = @cblock.clayouts
  end
end
