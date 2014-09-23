class C1circlesController < ApplicationController
  def index
    @comic1 = Comic1.find(params[:comic1_id])
    if request.format.symbol == :json
      @c1circles = @comic1.c1circles
        .includes(c1layout: :c1block)
        .page(params[:page])
        .per(15)
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def search
    @comic1 = Comic1.find(params[:comic1_id])
    @c1circles = @comic1
      .c1circles
      .includes(c1layout: :c1block)
      .page(params[:page])
      .per(15)

    %i(name kana).each do |sym|
      next if params[sym].blank?
      @c1circles = @c1circles.where(C1circle.arel_table[sym].matches("%#{params[sym]}%"))
    end

    respond_to do |format|
      format.json
    end
  end
end
