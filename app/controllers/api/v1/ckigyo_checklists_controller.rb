class Api::V1::CkigyosController < Api::V1::BaseController

  def index
    @comiket = Comiket.find(params[:id])
    @ckigyos = @comiket.ckigyos
  end
end
