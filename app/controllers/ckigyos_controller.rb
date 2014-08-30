class CkigyosController < ApplicationController
  def index
    if request.format.symbol == :json
      @comiket = Comiket.includes(:ckigyos).find(params[:comiket_id])
      @ckigyos = @comiket.ckigyos
    else
      @comiket = Comiket.find(params[:comiket_id])
      @page_sub_title = "#{@comiket.event_name} 企業ブース"
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @ckigyo = Ckigyo.includes(:ckigyo_links).find(params[:id])
    @prev_ckigyo = @ckigyo.previous
    @next_ckigyo = @ckigyo.next
    if user_signed_in?
      @ckigyo_checklists = CkigyoChecklist.where(ckigyo: @ckigyo, user: current_user)
    end
    respond_to do |format|
      format.html { render layout: false }
      format.json
    end
  end

  def show_modal_template
    render layout: false
  end

  def ranking
    @ckigyo_ranks = Comiket.find(params[:comiket_id])
                           .ckigyo_checklists
                           .group(:ckigyo_id)
                           .reorder('count_ckigyo_id DESC')
                           .limit(ranking_limit_param)
                           .count(:ckigyo_id)
    @ckigyos = Ckigyo.where(id: @ckigyo_ranks.keys)
                     .sort_by { |ckigyo| @ckigyo_ranks[ckigyo.id] }
                     .reverse
    respond_to do |format|
      format.json
    end
  end

  private

  def ranking_limit_param
    integer_string?(params[:limit]) ? params[:limit].to_i : 10
  end

end
