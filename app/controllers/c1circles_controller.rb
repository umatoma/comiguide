class C1circlesController < ApplicationController
  def index
    @comic1 = Comic1.includes(:c1circles).find(params[:comic1_id])
    @c1circles = @comic1.c1circles.page(params[:page])

    respond_to do |format|
      format.html
      format.json
    end
  end
end
