class ClayoutsController < ApplicationController
  def index
    @cblock = Cblock.includes(:clayouts)
                    .find_by(carea_id: params[:carea_id], id: params[:cblock_id])
    @clayouts = @cblock.clayouts
    respond_to do |format|
      format.json
    end
  end
end
