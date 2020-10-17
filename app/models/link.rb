class Link < ApplicationRecord
  validates :address, :short, :visits, presence: true
  validates :address, format: URI::regexp(%w[http https])
  validates :short, uniqueness: true
end
