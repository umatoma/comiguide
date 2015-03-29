# == Schema Information
#
# Table name: ckigyo_checklists
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  ckigyo_id  :integer          not null
#  comment    :string(255)
#  cost       :string(255)
#  color      :string(255)      default("black"), not null
#  rank       :integer          default(1), not null
#  created_at :datetime
#  updated_at :datetime
#

require 'csv'

class CkigyoChecklist < ActiveRecord::Base
  include Colors

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

  def self.csv_for_download(ckigyo_checklists)
    csv_data = CSV.generate do |csv|
      ckigyo_checklists.each do |checklist|
        csv << [
          checklist.ckigyo.kigyo_no,
          checklist.ckigyo.name,
          checklist.comment,
          checklist.cost,
          checklist.color
        ]
      end
    end
    csv_data.encode(Encoding::SJIS)
  end

  private

  def ckigyo_exists?
    ckigyo_id.present? && Ckigyo.find(ckigyo_id).present?
  end
end
