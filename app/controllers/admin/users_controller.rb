class Admin::UsersController < Admin::BaseController
  def index
    @users = User.page(params[:page]).per(15) if request_json?

    respond_to do |format|
      format.html
      format.json
    end
  end
end
