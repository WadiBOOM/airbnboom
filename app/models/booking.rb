class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat
  validates :starts_at, :ends_at, presence: true
end
