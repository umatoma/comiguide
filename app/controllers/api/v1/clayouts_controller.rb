class Api::V1::ClayoutsController < Api::V1::BaseController
  def index
    @cblock = Cblock.find(params[:cblock_id])
    @clayouts = @cblock.clayouts
  end
end
