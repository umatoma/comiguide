class Users::RestfulController < ApplicationController
  before_filter :authenticate_user!

  def index
    raise CanCan::AccessDenied.new unless current_user.admin?
    @users = User.all
  end

  def mypage
    if request.format.symbol == :json
      @user = current_user
      @comiket = Comiket.find(Comiket::MAIN_ID)
      @notifications = Notification.publish.recent
      @ckigyo_checklists = @comiket.ckigyo_checklists
                                   .where(user: current_user)
      @ccircle_checklists = @comiket.ccircle_checklists
                                    .where(user: current_user)
                                    .order(created_at: :desc)
    else
      @page_sub_title = 'マイページ'
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def profile
    @user = current_user
    @page_sub_title = 'プロフィール'
  end

  def my_info
    @user = current_user
  end
end
