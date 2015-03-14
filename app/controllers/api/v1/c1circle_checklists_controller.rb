class Api::V1::C1circleChecklistsController < Api::V1::BaseController
  load_and_authorize_resource only: [:update, :destroy]

  def index
    @comic1 = Comic1.find(params[:comic1_id])
    @c1circle_checklists = @comic1
                           .c1circle_checklists
                           .includes(c1layout: :c1block)
                           .where(user_id: current_user.id)
  end

  def create
    @c1circle_checklist = CcircleChecklist.new(c1circle_checklist_create_params)
    @c1circle_checklist.user = current_user
    @c1circle_checklist.save!
  end

  def update
    @c1circle_checklist.update!(c1circle_checklist_update_params)
  end

  def destroy
    @c1circle_checklist.destroy!
  end

  private

  def c1circle_checklist_create_params
    params
      .require(:c1circle_checklist)
      .permit(:comic1_id, :c1layout_id, :space_no_sub, :circle_name, :circle_url, :comment, :cost, :color)
  end

  def c1circle_checklist_update_params
    params
      .require(:c1circle_checklist)
      .permit(:c1layout_id, :space_no_sub, :circle_name, :circle_url, :comment, :cost, :color)
  end
end
