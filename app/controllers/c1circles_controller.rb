class C1circlesController < ApplicationController
  def index
    @comic1 = Comic1.find(params[:comic1_id])
    @c1circles = @comic1.c1circles.includes(c1layout: :c1block).page(params[:page])

    respond_to do |format|
      format.html
      format.json
    end
  end
end
