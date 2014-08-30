class Admin::NotificationsController < Admin::BaseController
  def index
    if request.format.symbol == :json
      @notifications = Notification.all
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

  def create
    @notification = Notification.new(create_params)
    respond_to do |format|
      if @notification.save
        format.json
      else
        format.json { render json: @notification.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    @notification = Notification.find(params[:id])
    respond_to do |format|
      if @notification.update(update_params)
        format.json
      else
        format.json { render json: @notification.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    respond_to do |format|
      if @notification.destroy
        format.json
      else
        format.json { render json: @notification.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # ----------------------------------------------------------
  # PrivateMethod
  # ----------------------------------------------------------

  private

  def create_params
    params.require(:notification).permit(:title, :content, :status)
  end

  def update_params
    params.require(:notification).permit(:title, :content, :status)
  end

end
