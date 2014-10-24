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

  def self.csv_for_download(c1circle_checklists)
    csv_data = CSV.generate do |csv|
      c1circle_checklists.each do |checklist|
        csv << [
          checklist.c1layout.c1block.name,
          checklist.c1layout.space_no,
          checklist.space_no_sub_name,
          checklist.circle_name,
          checklist.circle_url,
          checklist.comment,
          checklist.cost,
          checklist.color
        ]
      end
    end
    csv_data.encode(Encoding::SJIS)
  end

  def layout_info_simple
    "#{c1layout.layout_info_simple}#{space_no_sub_name}"
  end

  def space_no_sub_name
    SPACE_NO_SUB_NAME_HASH[space_no_sub]
  end
end
