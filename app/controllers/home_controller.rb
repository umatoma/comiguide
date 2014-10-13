class HomeController < ApplicationController
  skip_authorization_check

  def index
    @users_count = User.confirmed.count
    @ccircle_checklists_count = CcircleChecklist.all.count
    @ckigyo_checklists_count = CkigyoChecklist.all.count
    @c1circle_checklists_count = C1circleChecklist.all.count
  end

  def about
  end

  def contact
  end
end
