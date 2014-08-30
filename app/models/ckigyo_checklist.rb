class CkigyoChecklist < ActiveRecord::Base
  # ----------------------------------------------------------
  # Constant
  # ----------------------------------------------------------
  SELECT_COLOR_HASH = {
    black:  :black,
    gray:   :gray,
    red:    :red,
    green:  :green,
    blue:   :blue,
    yellow: :yellow,
    orange: :orange,
    purple: :purple
  }

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :user
  belongs_to :ckigyo

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :user_id,    presence: true, numericality: true
  validates :ckigyo_id,  presence: true, numericality: true
  validates :color,      presence: true
  validates :rank,       presence: true, numericality: true
  validate :ckigyo_exists?

  private

  def ckigyo_exists?
    ckigyo_id.present? && Ckigyo.find(ckigyo_id).present?
  end
end
