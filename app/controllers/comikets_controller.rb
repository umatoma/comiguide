class ComiketsController < ApplicationController

  def index
    @comikets = Comiket.all
  end

  def show
    @comiket = Comiket.find(params[:id])
    Pconf.set_sub_title(@comiket.event_name)
  end

end