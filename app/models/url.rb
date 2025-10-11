class Url < ApplicationRecord
  before_validation :generate_slug, on: :create
  validates :original_url, presence: true, format: URI.regexp(%w[http https])
  validates :slug, uniqueness: true
  has_many :clicks, dependent: :destroy


  private

def generate_slug
  return if slug.present?
  self.slug = SecureRandom.alphanumeric(6)
end

def expired?
  expires_at.present? && Time.current > expires_at
end
end
