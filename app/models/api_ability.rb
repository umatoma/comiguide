class ApiAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    cannot :manage, :all

    # ------------------------------------------------------------
    # CkigyoChecklist
    # ------------------------------------------------------------
    can [:update, :destroy], CkigyoChecklist do |ckigyo_checklist|
      ckigyo_checklist.user == user
    end

    # ------------------------------------------------------------
    # CcircleChecklist
    # ------------------------------------------------------------
    can [:update, :destroy], CcircleChecklist do |ccircle_checklist|
      ccircle_checklist.user == user
    end

    # ------------------------------------------------------------
    # C1circleChecklist
    # ------------------------------------------------------------
    can [:update, :destroy], C1circleChecklist do |c1circle_checklist|
      c1circle_checklist.user == user
    end
  end
end
