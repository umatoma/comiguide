class Api::V1::CareasController < Api::V1::BaseController
  def index
    @careas = Carea.includes(:cblocks).all
  end
end
