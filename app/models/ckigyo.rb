class Ckigyo < ActiveRecord::Base
  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :comiket
  has_many :ckigyo_links
  has_many :ckigyo_checklists

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :comiket_id, presence: true, numericality: true, uniqueness: { scope: :kigyo_no }
  validates :kigyo_no,   presence: true, numericality: true
  validates :name,       presence: true
  validates :x,          presence: true, numericality: true
  validates :y,          presence: true, numericality: true
  validates :w,          presence: true, numericality: true
  validates :h,          presence: true, numericality: true

  # ----------------------------------------------------------
  # Scope
  # ----------------------------------------------------------
  default_scope { order(kigyo_no: :asc) }

  # ----------------------------------------------------------
  # InstanceMethod
  # ----------------------------------------------------------
  def full_info
    "【#{kigyo_no}】#{name}"
  end

  def map_style
    kigyo_w = comiket.kigyo_w.to_f
    kigyo_h = comiket.kigyo_h.to_f
    left    = 100.to_f * x.to_f / kigyo_w
    top     = 100.to_f * y.to_f / kigyo_h
    width   = 100.to_f * w.to_f / kigyo_w
    height  = 100.to_f * h.to_f / kigyo_h
    "left: %f%%; top: %f%%; width: %f%%; height: %f%%;"%[left, top, width, height]
  end

  def previous
    Ckigyo.where(comiket_id: comiket_id)
          .where(Ckigyo.arel_table[:kigyo_no].lt(kigyo_no))
          .reorder(kigyo_no: :desc)
          .first
  end

  def next
    Ckigyo.where(comiket_id: comiket_id)
          .where(Ckigyo.arel_table[:kigyo_no].gt(kigyo_no))
          .reorder(kigyo_no: :asc)
          .first
  end
end
