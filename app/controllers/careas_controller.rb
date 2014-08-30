class CareasController < ApplicationController
  def index
    @careas = Carea.includes(:cblocks).all
    respond_to do |format|
      format.json
    end
  end
end
