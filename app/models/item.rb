class Item < ApplicationRecord
  belongs_to :seller, class_name: "User", foreign_key: "seller_id"
  belongs_to :buyer, class_name: "User", foreign_key: "buyer_id", optional: true 
  has_many :category_items 
  has_many :categories, through: :category_items
  validates :name, :desc, presence: true 
  validates :price, presence: true, format: {with: /\A\d+(?:\.\d{0,2})?\z/, message: "Must be a dollar amount."}, numericality:{greather_than: 0, less_than: 10000}
end
