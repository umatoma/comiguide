class Api::V1::CcircleChecklistsController < Api::V1::BaseController
  def index
    @comiket = Comiket.find(params[:comiket_id])
    @ccircle_checklists = @comiket.ccircle_checklists.where(user_id: current_user.id)
  end
end
