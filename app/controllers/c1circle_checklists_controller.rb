class C1circleChecklistsController < ApplicationController
  authorize_resource

  def index
    @comic1 = Comic1.find(params[:comic1_id])
    if request.format.symbol == :json
      @c1circle_checklists = @comic1.c1circle_checklists
                                    .includes(c1layout: { c1block: :c1layouts })
                                    .where(user: current_user)
      @c1blocks = @comic1.c1blocks
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  def create
    @c1circle_checklist = C1circleChecklist.new(create_params)
    @c1circle_checklist.user = current_user
    respond_to do |format|
      if @c1circle_checklist.save
        @c1blocks = C1block.where(comic1_id: @c1circle_checklist.comic1_id)
        @c1layouts = C1layout.where(c1block_id: @c1circle_checklist.c1layout.c1block_id)
        format.json
      else
        format.json { render json: @c1circle_checklist.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    @c1circle_checklist = C1circleChecklist.find(params[:id])
    respond_to do |format|
      if @c1circle_checklist.update(update_params)
        format.json
      else
        format.json { render json: @c1circle_checklist.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @c1circle_checklist = C1circleChecklist.find(params[:id])
    respond_to do |format|
      if @c1circle_checklist.destroy
        format.json
      else
        format.json { render json: @c1circle_checklist.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # ----------------------------------------------------------
  # PrivateMethod
  # ----------------------------------------------------------

  private

  def create_params
    params.require(:c1circle_checklist)
          .permit(:comic1_id, :c1layout_id, :space_no_sub, :circle_name, :circle_url, :comment, :cost, :color)
  end

  def update_params
    params.require(:c1circle_checklist)
          .permit(:c1layout_id, :space_no_sub, :circle_name, :circle_url, :comment, :cost, :color)
  end
end
