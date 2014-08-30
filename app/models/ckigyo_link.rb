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