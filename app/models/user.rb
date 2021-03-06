class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :flats, dependent: :destroy
  has_many :bookings
  has_many :bookings_as_owner, through: :flats, source: :bookings
  validates :firstname, :lastname, :email, :address, presence: true
  validates :email, uniqueness: true
end
