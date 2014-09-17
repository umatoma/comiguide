class C1circleChecklist < ActiveRecord::Base
  include Colors

  SPACE_NO_SUB_NAME_HASH = {
    0 => 'a',
    1 => 'b'
  }

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :user
  belongs_to :comic1
  belongs_to :c1layout

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :user_id,      presence: true, numericality: true
  validates :comic1_id,    presence: true, numericality: true
  validates :c1layout_id,   presence: true, numericality: true
  validates :space_no_sub, presence: true, numericality: true
  validates :circle_name,  presence: true
  validates :color,        presence: true
  validates :rank,         presence: true, numericality: true

  def layout_info_simple
    "#{c1layout.layout_info_simple}#{space_no_sub_name}"
  end

  def space_no_sub_name
    SPACE_NO_SUB_NAME_HASH[space_no_sub]
  end
end
