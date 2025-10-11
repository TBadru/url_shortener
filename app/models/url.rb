class Url < ApplicationRecord
  before_validation :generate_slug, on: :create
  validates :original_url, presence: true, format: URI.regexp(%w[http https])
  validates :slug, uniqueness: true

  private

  def generate_slug
    self.slug ||= SecureRandom.alphanumeric(6)
  end
end
