class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participations, dependent: :destroy
  has_many :events, through: :participations
  has_many :participating_events, through: :participations, source: :event

  # Validation
  has_one_attached :avatar
  validates :first_name, presence: true, length: { maximum: 50 }, format: { without: /\s/ }
  validates :last_name, presence: true, length: { maximum: 50 }, format: { without: /\s/ }
  validates :phone, presence: true, length: { maximum: 20 }
  validates :biography, length: { maximum: 1000 }



end
