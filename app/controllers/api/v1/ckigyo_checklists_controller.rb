class Api::V1::CkigyoChecklistsController < Api::V1::BaseController
  load_and_authorize_resource only: [:update, :destroy]

  def index
    @comiket = Comiket.find(params[:comiket_id])
    @ckigyo_checklists = @comiket
                         .ckigyo_checklists
                         .includes(:ckigyo)
                         .where(user_id: current_user.id)
  end

  def create
    @ckigyo_checklist = CkigyoChecklist.new(ckigyo_checklist_create_params)
    @ckigyo_checklist.user = current_user
    @ckigyo_checklist.save!
  end

  def update
    @ckigyo_checklist.update!(ckigyo_checklist_update_params)
  end

  def destroy
    @ckigyo_checklist.destroy!
  end

  private

  def ckigyo_checklist_create_params
    params.require(:ckigyo_checklist).permit(:ckigyo_id, :comment, :cost, :color)
  end

  def ckigyo_checklist_update_params
    params.require(:ckigyo_checklist).permit(:ckigyo_id, :comment, :cost, :color)
  end
end
