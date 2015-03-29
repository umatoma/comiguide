# == Schema Information
#
# Table name: ckigyo_links
#
#  id         :integer          not null, primary key
#  ckigyo_id  :integer          not null
#  url        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class CkigyoLink < ActiveRecord::Base

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  belongs_to :comiket
  belongs_to :ckigyo

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :ckigyo_id, presence: true, uniqueness: { scope: :url }
  validates :url,       presence: true

end
