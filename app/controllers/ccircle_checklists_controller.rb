class CcircleChecklistsController < ApplicationController
  authorize_resource

  def index
    @comiket = Comiket.find(params[:comiket_id])
    if request.format.symbol == :json
      @ccircle_checklists = @comiket.ccircle_checklists
                                    .includes(clayout: :cblock)
                                    .where(user: current_user)
      @careas = Carea.includes(:cblocks).all
    else
      @page_sub_title = "#{@comiket.event_name} サークルチェックリスト"
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @ccircle_checklist = CcircleChecklist.new(create_params)
    @ccircle_checklist.user = current_user
    respond_to do |format|
      if @ccircle_checklist.save
        @careas = Carea.includes(:cblocks).all
        format.json
      else
        format.json { render json: @ccircle_checklist.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ccircle_checklist = CcircleChecklist.find(params[:id])
    respond_to do |format|
      if @ccircle_checklist.update(update_params)
        format.json
      else
        format.json { render json: @ccircle_checklist.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ccircle_checklist = CcircleChecklist.find(params[:id])
    respond_to do |format|
      if @ccircle_checklist.destroy
        format.json
      else
        format.json { render json: @ccircle_checklist.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def create_map
    @comiket = Comiket.find(params[:comiket_id])
    pdf = CcircleChecklistMapPdf.new(
      comiket_id: @comiket.id,
      user_id: current_user.id,
      cmap_id: params[:cmap_id],
      day: params[:day],
      draw_line: params[:line]
    )
    respond_to do |format|
      if pdf.valid?
        format.pdf do
          pdf.draw
          send_data pdf.render, filename: checklist_filename('pdf'), disposition: 'inline'
        end
      else
        format.pdf { head :no_content }
      end
    end
  end

  def download
    @comiket = Comiket.find(params[:comiket_id])
    @ccircle_checklists = @comiket.ccircle_checklists.includes(clayout: { cblock: :carea }).where(user: current_user)
    respond_to do |format|
      format.csv do
        send_data CcircleChecklist.csv_for_download(@ccircle_checklists), filename: checklist_filename('csv')
      end
    end
  end

  private

  def create_params
    params.require(:ccircle_checklist)
          .permit(:comiket_id, :clayout_id, :space_no_sub, :day, :circle_name, :circle_url, :comment, :cost, :color)
  end

  def update_params
    params.require(:ccircle_checklist)
          .permit(:clayout_id, :space_no_sub, :day, :circle_name, :circle_url, :comment, :cost, :color)
  end

  def checklist_filename(extention)
    "ccircle_checklist_#{Time.now.to_i}.#{extention}"
  end
end
