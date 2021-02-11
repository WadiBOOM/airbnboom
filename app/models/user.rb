class User < ApplicationRecord
  has_many :flats, dependent: :destroy
  has_many :bookings
  has_many :bookings_as_owner, through: :flats, source: :bookings
  validates :firstname, :lastname, :email, :address, presence: true
  validates :email, uniqueness: true
  # devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
