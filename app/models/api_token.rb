# == Schema Information
#
# Table name: api_tokens
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  token      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class ApiToken < ActiveRecord::Base
  # ----------------------------------------------------------
  # Association
  # ----------------------------------------------------------
  belongs_to :user, -> { where.not(confirmed_at: nil) }

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :user_id, presence: true
  validates :token, presence: true

  def set_token
    self.token = SecureRandom.uuid
  end
end
