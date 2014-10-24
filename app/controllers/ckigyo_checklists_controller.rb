class CkigyoChecklistsController < ApplicationController
  authorize_resource

  def index
    @comiket = Comiket.find(params[:comiket_id])
    if request.format.symbol == :json
      @ckigyos = @comiket.ckigyos
      @ckigyo_checklists = @comiket
        .ckigyo_checklists
        .includes(ckigyo: :comiket)
        .where(user: current_user)
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @ckigyo_checklist = CkigyoChecklist.new(create_params)
    @ckigyo_checklist.user = current_user
    respond_to do |format|
      if @ckigyo_checklist.save
        format.json
      else
        format.json { render json: @ckigyo_checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @ckigyo_checklist = CkigyoChecklist.includes(:ckigyo).find(params[:id])
    respond_to do |format|
      if @ckigyo_checklist.update(update_params)
        format.json
      else
        format.json { render json: @ckigyo_checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ckigyo_checklist = CkigyoChecklist.includes(:ckigyo).find(params[:id])
    respond_to do |format|
      if @ckigyo_checklist.destroy
        format.json
      else
        format.json { render json: @ckigyo_checklist.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_map
    @comiket = Comiket.find(params[:comiket_id])
    respond_to do |format|
      format.pdf do
        pdf = CkigyoChecklistMapPdf.new(@comiket.id, current_user.id)
        send_data pdf.render, filename: checklist_filename('pdf'), disposition: 'inline'
      end
    end
  end

  def download
    @comiket = Comiket.find(params[:comiket_id])
    @ckigyo_checklists = @comiket.ckigyo_checklists.includes(:ckigyo).where(user: current_user)
    respond_to do |format|
      format.csv do
        send_data CkigyoChecklist.csv_for_download(@ckigyo_checklists), filename: checklist_filename('csv')
      end
    end
  end

  private

  def create_params
    params.require(:ckigyo_checklist).permit(:ckigyo_id, :comment, :cost, :color)
  end

  def update_params
    params.require(:ckigyo_checklist).permit(:comment, :cost, :color)
  end

  def checklist_filename(extention)
    "ckigyo_checklist_#{Time.now.to_i}.#{extention}"
  end
end
