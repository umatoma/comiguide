class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  protected

  def after_update_path_for(resource)
    mypage_users_path
  end
end
