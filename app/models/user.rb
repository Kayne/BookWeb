class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :booksassignments
  has_many :books, :through => :booksassignments

  attr_accessor :login
  attr_accessible :login

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  def self.find_for_authentication(conditions)
    login = conditions.delete(:login)
      where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
      end

end
