
class Url < ApplicationRecord
  has_many :clicks, dependent: :destroy

  before_create :generate_short_slug

  validates :original_url, presence: true, format: URI.regexp(%w[http https])
  validates :slug, uniqueness: true

  def expired?
    expires_at.present? && expires_at < Time.current
  end

  private

  def generate_short_slug
    self.slug ||= SecureRandom.alphanumeric(6)
  end
end
