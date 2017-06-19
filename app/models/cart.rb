class Cart < ApplicationRecord
    has_many :cart_items, dependent: :delete_all
    
    # def subtotal
    #     cart_items.collect { |ci| ci.valid? ? (ci.quantity * 10) : 0 }.sum
    # end
    def total_add(variant,quantity)
        puts id
        self.total+= quantity.to_f
        unit_price= variant.try(:prices).try(:first).try(:value)
        puts unit_price
        self.total_price+= unit_price*quantity.to_f
        puts self.total_price
        self.save
    end
    def total_substract(variant,quantity)
        self.total-= quantity.to_f
        unit_price= variant.try(:prices).try(:first).try(:value)
        self.total_price-=  unit_price*quantity.to_f 
        self.save
    end
end
