class C1layoutsController < ApplicationController
  def index
    @c1block = C1block.includes(:c1layouts)
                     .find_by(id: params[:c1block_id])
    @c1layouts = @c1block.c1layouts
    respond_to do |format|
      format.json
    end
  end
end
