class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authenticate_user_from_api_token, only: :sign_in

  def sign_in
    @user = User.find_by(email: user_sign_in_params[:email])
    if @user && @user.valid_password?(user_sign_in_params[:password])
      if @user.confirmed_at?
        @api_token = ApiToken.find_or_initialize_by(user_id: @user.id)
        @api_token.set_token
        @api_token.save!
      else
        render json: { error: 'You have to confirm your account before continuing.' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Invalid email or password.' }, status: :unprocessable_entity
    end
  end

  private

  def user_sign_in_params
    params.require(:user).permit(:email, :password)
  end
end
