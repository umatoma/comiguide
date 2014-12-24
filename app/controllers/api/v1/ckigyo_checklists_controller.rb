class Api::V1::CkigyoChecklistsController < Api::V1::BaseController
  def index
    @comiket = Comiket.find(params[:id])
    @ckigyo_checklists = @comiket.ckigyo_checklists.where(user_id: current_user.id)
  end

  def create
    @ckigyo_checklist = CkigyoChecklist.new(ckigyo_checklist_create_params)
    @ckigyo_checklist.user = current_user
    @ckigyo_checklist.save!
  end

  private

  def ckigyo_checklist_create_params
    params.require(:ckigyo_checklist).permit(:ckigyo_id, :comment, :cost, :color)
  end
end