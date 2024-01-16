class User < ApplicationRecord
  validates_presence_of :email, :password
  validates_confirmation_of :password
  validates :email, uniqueness: { case_sesitive: false}
  has_secure_password
  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(26)
  end
end
