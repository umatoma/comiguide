class Api::V1::NotificationsController < Api::V1::BaseController
  def index
    @notifications = Notification
      .publish
      .android
      .page(params[:page])
      .per(15)
  end

  def show
    @notification = Notification.publish.android.find(params[:id])
  end
end
