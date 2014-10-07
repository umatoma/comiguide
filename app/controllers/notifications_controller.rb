class NotificationsController < ApplicationController
  def index
    if request_json?
      @notifications = Notification
        .publish
        .page(params[:page])
        .per(15)
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @notification = Notification.find(params[:id])
    respond_to do |format|
      format.json
    end
  end
end
