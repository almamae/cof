class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :name, :facebook, :twitter, :occupation, :g_plus, :user_type, :isReported, :isBanned
  has_many :posts, :dependent => :destroy
  make_flagger
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.findreported()
    find(isReported = 1)
  end

  def self.authadmin(email)
    user = find_by_email(email)
    if user && user.user_type == "admin"
      user
    else
        nil
    end
  end
end
