class Variant < ApplicationRecord
  belongs_to :product
  has_many :prices, dependent: :destroy
  has_many :cart_items, dependent: :delete_all
  accepts_nested_attributes_for :prices , allow_destroy: true
  
  def self.update (id ,attributes )
    if id.is_a?(Array)
          idx = -1
          id.collect do |one_id| 
            idx += 1
            begin 
              r =update(one_id, attributes[idx]) 
              rez = {:id => one_id , :status => "ok" }
            rescue Exception => exc 
              rez = {:id => one_id , :status => "error", :error => exc.message }
            
            end
          end
        else
          object = find(id)
          existed = object.prices.pluck(:name,:id).to_h
          object.prices.delete_all
          object.update_attributes(attributes)
          object
    end
  end
  
end
