class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item
end

enum making_status: { cannot: 0, waiting_for_production: 1, production: 2, production_completed:3 }
