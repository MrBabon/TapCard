class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # Validation

  validates :first_name, presence: true, length: { maximum: 50 }, format: { without: /\s/ }
  validates :last_name, presence: true, length: { maximum: 50 }, format: { without: /\s/ }
  validates :phone, presence: true, length: { maximum: 20 }
  validates :biography, length: { maximum: 1000 }

end
