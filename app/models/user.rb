# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string(255)      not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # ----------------------------------------------------------
  # Relation
  # ----------------------------------------------------------
  has_many :ckigyo_checklists
  has_many :ccircle_checklists
  has_many :c1circle_checklists
  has_one :api_token, dependent: :destroy

  # ----------------------------------------------------------
  # Validation
  # ----------------------------------------------------------
  validates :username, presence: true, format: { with: /\A[a-zA-Z0-9\-_]+\Z/i }, length: { minimum: 4 }

  # ----------------------------------------------------------
  # Scope
  # ----------------------------------------------------------
  scope :confirmed, -> { where.not(confirmed_at: nil) }

  # ----------------------------------------------------------
  # Callback
  # ----------------------------------------------------------
  after_create :add_role_normal

  def remember_me
    true
  end

  def undefined_passsword?
    !!/\A.+@undefined\z/i.match(email)
  end

  private

  def add_role_normal
    add_role :normal
  end
end
