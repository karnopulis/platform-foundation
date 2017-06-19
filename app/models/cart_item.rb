class CartItem < ApplicationRecord
  belongs_to :variant
  belongs_to :cart
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :ku, numericality: { only_integer: true }

  validate :variant_present
#  validate :order_present
  
  private
  def variant_present
    if variant.nil?
      errors.add(:product, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  # def finalize
  #   self[:unit_price] = unit_price
  #   self[:total_price] = quantity * self[:unit_price]
  # end

  
end
