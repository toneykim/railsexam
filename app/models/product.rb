class Product < ActiveRecord::Base
  belongs_to :user
  has_many :buyings

  has_many :product_owners, through: :buyings, source: :user

  validates :item_name, :amount, presence: true 


end
