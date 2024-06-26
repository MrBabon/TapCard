class User < ApplicationRecord
  after_create :create_default_repertoire
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # REPERTOIRE
  has_one :repertoire, dependent: :destroy
  # CHATROOM & MESSAGE
  has_many :messages, dependent: :destroy
  # USERS_CONTACT_GROUPS
  has_many :users_contact_groups
  has_many :contact_groups, through: :users_contact_groups
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
  # CONTACT ENTREPRISE
  has_many :contact_entreprises, dependent: :destroy
 

  # Validation
  has_one_attached :avatar
  validates :first_name, presence: true, length: { maximum: 17 }, format: { without: /\s/ }
  validates :last_name, presence: true, length: { maximum: 20 }, format: { without: /\s/ }
  validates :phone, presence: true, length: { maximum: 20 }
  validates :biography, length: { maximum: 1000 }
  validate :must_not_be_employee_and_entrepreneur

  enum industry: {
    agriculture: "Agriculture",
    art_design: "Art & Design",
    education: "Education",
    energy: "Energy",
    engineering: "Engineering",
    environment: "Environment",
    finance: "Finance",
    health: "Healthcare",
    human_resources: "Human Resources",
    manufacturing: "Manufacturing",
    media: "Media",
    professional_services: "Professional Services",
    public_administration: "Public Administration",
    real_estate: "Real Estate",
    retail: "Retail",
    science: "Science",
    technology: "Technology",
    telecommunications: "Telecommunications",
    tourism: "Tourism",
    transportation: "Transportation",
  }

  validates :industry, inclusion: { in: industries.keys, message: "Industry invalid" }, allow_blank: true

 
    # PG SEARCH
    include PgSearch::Model
    pg_search_scope :search_by_first_name,
      against: :first_name,
      using: {
        tsearch: { prefix: true } 
    }
    
    pg_search_scope :search_by_last_name,
    against: :last_name,
    using: {
      tsearch: { prefix: true } 
    }
   
  def chatrooms
    Chatroom.where("user1_id = ? OR user2_id = ?", self.id, self.id)
  end
  
  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
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
      association_request = AssociationRequest.new(user: self, entreprise: entreprise, status: 'pending')
      if association_request.save
        return true
      else
        self.errors.add(:base, "Impossible de créer la demande d'association : #{association_request.errors.full_messages.join(', ')}")
        return false
      end
    else
      self.errors.add(:entreprise_code, "invalide.")
      return false
    end
  end
  
  def need_to_process_enterprise_code?(submitted_code)
    if self.entreprise_code.blank? || self.entreprise_code != submitted_code
      true
    else
      false
    end
  end

  def add_to_everyone_group
    everyone_group = ContactGroup.find_by(name: 'Everyone')
    UsersContactGroup.find_or_create_by(user: self, contact_group: everyone_group)
  end
  

  private

  def must_not_be_employee_and_entrepreneur
    if employee_relationships.exists? && entrepreneurs.exists?
      errors.add(:base, 'A user cannot be both an employee and an entrepreneur.')
    end
  end

  def create_default_repertoire
    create_repertoire!
  end

end
