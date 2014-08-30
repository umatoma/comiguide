class Comic1sController < ApplicationController
  def show
    @comic1 = Comic1.find(params[:id])
  end
end
