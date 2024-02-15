class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :participations, dependent: :destroy
  has_many :directors, dependent: :destroy

  has_many :entrepreneurs, dependent: :destroy
  has_many :employee_relationships, class_name: 'Employee', dependent: :destroy
  has_many :entreprises, through: :entrepreneurs
  has_many :employee_entreprises, through: :employee_relationships, source: :entreprise

  has_many :events, through: :participations
  has_many :participating_events, through: :participations, source: :event
  # FOLLOW
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following, through: :following_relationships, source: :following
  # Validation
  has_one_attached :avatar
  validates :first_name, presence: true, length: { maximum: 50 }, format: { without: /\s/ }
  validates :last_name, presence: true, length: { maximum: 50 }, format: { without: /\s/ }
  validates :phone, presence: true, length: { maximum: 20 }
  validates :biography, length: { maximum: 1000 }

  enum industry: {
    technology: "Technology",
    engineering: "Engineering",
    health: "Healthcare",
    finance: "Finance",
    education: "Education",
    retail: "Retail",
    manufacturing: "Manufacturing",
    transportation: "Transportation",
    real_estate: "Real Estate",
    tourism: "Tourism",
    agriculture: "Agriculture",
    media: "Media",
    professional_services: "Professional Services",
    energy: "Energy",
    public_administration: "Public Administration",
    telecommunications: "Telecommunications",
    human_resources: "Human Resources",
    science: "Science",
    environment: "Environment",
    art_design: "Art & Design"
  }

  validates :industry, inclusion: { in: industries.keys, message: "Industry invalid" }, allow_blank: true
  
  def industry_form_value
    industry.presence || "Industry not specified"
  end

  def director?
    directors.exists?(user: self)
  end

  def entrepreneurs?
    entrepreneurs.exists?(user: self)
  end
  
  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  def is_following?(user_id)
    relationship = Follow.find_by(follower_id: id, following_id: user_id)
    return true if relationship
  end

end
