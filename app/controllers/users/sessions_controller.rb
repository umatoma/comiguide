class Users::SessionsController < Devise::SessionsController
  skip_authorization_check

  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end
end
