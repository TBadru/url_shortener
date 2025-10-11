class AdminUser < ApplicationRecord
  # Devise modules
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  # Allowlist attributes searchable via Ransack
  def self.ransackable_attributes(auth_object = nil)
    %w[id email created_at updated_at remember_created_at reset_password_sent_at]
  end
end
