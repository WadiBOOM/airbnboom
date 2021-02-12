class Flat < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  has_many :bookings
  validates :title, :description, :price, :address, :capacity, presence: true
  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?
end
