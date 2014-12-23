class Api::V1::UsersController < Api::V1::BaseController
  def index
    @user = User.find(1)
  end
end
