class User < ActiveRecord::Base
  has_secure_password
  has_many :products
  has_many :buyings

  has_many :bought_products, through: :buyings, source: :product

	EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :first_name, :last_name, :password, presence: true, length: {minimum:2} 
  validates :email, presence: true, uniqueness: {case_sensitive:false}, format: {with: EMAIL_REGEX}

  before_save :downcase_email


  private

  	def downcase_email
  		self.email.downcase!
  	end


end
