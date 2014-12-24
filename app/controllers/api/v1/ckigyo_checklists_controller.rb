class Api::V1::CkigyoChecklistsController < Api::V1::BaseController
  def index
    @comiket = Comiket.find(params[:id])
    @ckigyo_checklists = @comiket.ckigyo_checklists.where(user_id: current_user.id)
  end
end
