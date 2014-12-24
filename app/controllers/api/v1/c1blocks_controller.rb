class Api::V1::C1blocksController < Api::V1::BaseController
  def index
    @comic1 = Comic1.find(params[:comic1_id])
    @c1blocks = @comic1.c1blocks
  end
end
