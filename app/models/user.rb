class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :booksassigments, :dependent => :destroy
  has_many :books, :through => :booksassigments

  attr_accessor :login
  attr_readonly :username, :login

  validates_presence_of :username, :email

  extend FriendlyId
  friendly_id :username
  # Avatar by paperclip gem
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :avatar, :admin

  protected

  def self.find_for_authentication(conditions)
    login = conditions.delete(:login)
    where(conditions).where(["username = :value OR email = :value", { :value => login }]).first
  end

  def self.find_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    case_insensitive_keys.each { |k| attributes[k].try(:downcase!) }
    
    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:login)
        login = attributes.delete(:login)
	record = find_record(login)
      else  
        record = where(attributes).first
      end  
    end  
 
    unless record
      record = new
      required_attributes.each do |key|
	value = attributes[key]
        record.send("#{key}=", value)
	record.errors.add(key, value.present? ? error : :blank)
      end  
    end  
    record
  end

  def self.find_record(login)
    where({:username => login} | { :email => login}).first
  end
end
