class Api::V1::CkigyosController < Api::V1::BaseController
  skip_before_action :authenticate_user_from_api_token, only: :index

  def index
    @comiket = Comiket.find(params[:id])
    @ckigyos = @comiket.ckigyos
  end
end
