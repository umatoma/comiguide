class CkigyoChecklistsController < ApplicationController
  authorize_resource

  def index
    @comiket = Comiket.includes(:ckigyos).find(params[:comiket_id])
    @ckigyos = @comiket.ckigyos
    @ckigyo_checklists = @comiket.ckigyo_checklists
                                 .includes(ckigyo: :comiket)
                                 .where(user: current_user)
    respond_to do |format|
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
    @comiket = Comiket.includes(:ckigyos).find(params[:comiket_id])
    @ckigyos = @comiket.ckigyos
    @ckigyo_checklists = @comiket.ckigyo_checklists
      .includes(ckigyo: :comiket)
      .where(user: current_user)
    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new
        send_data pdf.render, filename: 'report.pdf'
      end
    end
  end

  # ----------------------------------------------------------
  # PrivateMethod
  # ----------------------------------------------------------

  private

  def create_params
    params.require(:ckigyo_checklist).permit(:ckigyo_id, :comment, :cost, :color)
  end

  def update_params
    params.require(:ckigyo_checklist).permit(:comment, :cost, :color)
  end
end
