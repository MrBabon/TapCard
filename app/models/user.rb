class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # PARTICIPATION
  has_many :participations, dependent: :destroy
  has_many :participating_events, through: :participations, source: :event
  has_many :events, through: :participations
  # DIRECTOR
  has_many :directors, dependent: :destroy
  # ENTREPRENEUR
  has_many :entrepreneurs, dependent: :destroy
  has_many :entreprises_as_owner, through: :entrepreneurs, source: :entreprise
  # EMPLOYEE
  has_many :employee_relationships, class_name: 'Employee', dependent: :destroy
  has_many :entreprises_as_employee, through: :employee_relationships, source: :entreprise
  # ASSOCIATION REQUEST
  has_many :association_requests, dependent: :destroy
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
  
  def full_name
    "#{first_name} #{last_name}"
  end

  def industry_form_value
    industry.presence || "Industry not specified"
  end

  def director?
    directors.exists?(user: self)
  end

  def entrepreneurs?
    entrepreneurs.exists?(user: self)
  end

  def employee_relationships?
    employee_relationships.exists?(user: self)
  end

  def associate_with_entreprise(parrainage_code)
    entreprise = Entreprise.find_by(parrainage_code: parrainage_code)
    if entreprise
      # Supposons qu'il est toujours approprié de créer une demande d'association,
      # indépendamment des demandes précédentes.
      association_request = AssociationRequest.new(user: self, entreprise: entreprise, status: 'pending')
      if association_request.save
        return true
      else
        self.errors.add(:base, "Impossible de créer la demande d'association : #{association_request.errors.full_messages.join(', ')}")
        return false
      end
    else
      self.errors.add(:entreprise_code, "Code de parrainage invalide.")
      return false
    end
  end
  
  def need_to_process_enterprise_code?(submitted_code)
    if self.entreprise_code.blank? || self.entreprise_code != submitted_code
      # Si aucun code n'a été soumis précédemment, ou si le code soumis est différent du dernier code traité,
      # nous considérons que le code doit être traité.
      true
    else
      # Si le code soumis est le même que le dernier code traité, aucun traitement supplémentaire n'est nécessaire.
      false
    end
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
