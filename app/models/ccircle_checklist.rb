class CcircleChecklist < ActiveRecord::Base
  include Colors

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :user
  belongs_to :comiket
  belongs_to :clayout

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :user_id,     presence: true, numericality: true
  validates :comiket_id,  presence: true, numericality: true
  validates :clayout_id,  presence: true, numericality: true
  validates :day,         presence: true, numericality: true
  validates :circle_name, presence: true
  validates :color,       presence: true
  validates :rank,        presence: true, numericality: true

  enum space_no_sub: [:a, :b]

  def self.csv_for_download(ccircle_checklists)
    csv_data = CSV.generate do |csv|
      ccircle_checklists.each do |checklist|
        csv << [
          checklist.day_name,
          checklist.clayout.cblock.carea.name,
          checklist.clayout.cblock.name,
          checklist.clayout.space_no,
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

  def day_name
    "#{day}日目"
  end
end
