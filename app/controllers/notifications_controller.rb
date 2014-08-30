class NotificationsController < ApplicationController
  authorize_resource

  def index
    @notifications = Notification.all
    respond_to do |format|
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
