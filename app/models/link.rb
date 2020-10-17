class Link < ApplicationRecord
  validates :address, :shortcut, :visits, presence: true
  validates :address, format: URI::regexp(%w[http https])
  validates :shortcut, uniqueness: true
end
