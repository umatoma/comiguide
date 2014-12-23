class ApiToken < ActiveRecord::Base
  # ----------------------------------------------------------
  # Association
  # ----------------------------------------------------------
  belongs_to :user

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :user_id, presence: true
  validates :token, presence: true

  # ----------------------------------------------------------
  # Callback
  # ----------------------------------------------------------
  after_initialize :set_token

  def set_token
    self.token = SecureRandom.uuid
  end
end
