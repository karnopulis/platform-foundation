json.variants do
    json.array! @object  do |nc|
                    json.id nc.id
#                   json.sku nc.sku
                    json.quantity nc.quantity
                    json.product_id nc.product_id
                    nc.prices.each do |pc|
                        json.set! pc.name,pc.value
                    end
                    
                end
    

end