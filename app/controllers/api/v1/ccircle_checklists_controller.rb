class Api::V1::CcircleChecklistsController < Api::V1::BaseController
  load_and_authorize_resource only: [:update, :destroy]

  def index
    @comiket = Comiket.find(params[:comiket_id])
    @ccircle_checklists = @comiket.ccircle_checklists.where(user_id: current_user.id)
  end

  def create
    @ccircle_checklist = CcircleChecklist.new(ccircle_checklist_create_params)
    @ccircle_checklist.user = current_user
    @ccircle_checklist.save!
  end

  def update
    @ccircle_checklist.update!(ccircle_checklist_update_params)
  end

  def destroy
    @ccircle_checklist.destroy!
  end

  private

  def ccircle_checklist_create_params
    params
      .require(:ccircle_checklist)
      .permit(:comiket_id, :clayout_id, :space_no_sub, :day, :circle_name, :circle_url, :comment, :cost, :color)
  end

  def ccircle_checklist_update_params
    params
      .require(:ccircle_checklist)
      .permit(:clayout_id, :space_no_sub, :day, :circle_name, :circle_url, :comment, :cost, :color)
  end
end
