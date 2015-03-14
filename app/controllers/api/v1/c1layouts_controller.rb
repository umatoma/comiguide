class Api::V1::C1layoutsController < Api::V1::BaseController
  def index
    @c1block = C1block.find(params[:c1block_id])
    @c1layouts = @c1block.c1layouts
  end
end
