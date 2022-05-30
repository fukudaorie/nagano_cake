class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre, dependent: :destroy
  has_many :cart_items
  has_many :order_details, dependent: :destroy
  
  def add_tax_price
    (self.price*1.10).floor
  end
end

