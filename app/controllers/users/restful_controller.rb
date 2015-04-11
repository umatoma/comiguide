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
      @notifications = Notification.publish.web.recent
      @ckigyo_checklists = @comiket.ckigyo_checklists
                                   .includes(ckigyo: :comiket)
                                   .where(user: current_user)
                                   .order(created_at: :desc)
      @ccircle_checklists = @comiket.ccircle_checklists
                                    .includes(clayout: :cblock)
                                    .where(user: current_user)
                                    .order(created_at: :desc)
      @comic1 = Comic1.find(Comic1::MAIN_ID)
      @c1circle_checklists = @comic1.c1circle_checklists
                                     .includes(c1layout: { c1block: :c1layouts })
                                     .where(user: current_user)
                                     .order(created_at: :desc)
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
