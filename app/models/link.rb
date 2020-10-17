class Link < ApplicationRecord
  validates :address, :short, :visits, presence: true
  validates :short, uniqueness: true
end
