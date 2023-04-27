class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable , :trackable


  #Association
  belongs_to :userable , polymorphic: true

  # Validations
  validates :email, uniqueness: true
  validates :email , format: URI::MailTo::EMAIL_REGEXP

  # Devise authentication 
  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end

  #role checking methods
  def rider?
    if role == 'Rider'
      return true
    else
      return false
    end
  end


  def driver?
    if role == "Driver"
      return true
    else
      return false
    end
  end




end
