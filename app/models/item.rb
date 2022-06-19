class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  
  paginates_per 10
  
  def add_tax_price
    (price*1.1).floor
  end
end

