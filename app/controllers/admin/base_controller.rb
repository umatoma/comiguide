class Admin::BaseController < ApplicationController
  # ----------------------------------------------------------
  # BeforeAction
  # ----------------------------------------------------------
  before_action :verify_admin

  private

  def verify_admin
    redirect_to root_url unless user_signed_in? && current_user.has_role?(:admin)
  end
end
