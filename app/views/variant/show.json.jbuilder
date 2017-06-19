    json.id @result.id
#   json.sku @result.sku
    json.quantity @result.quantity
    json.product_id @result.product_id
    @result.prices.each do |pc|
        json.set! pc.name,pc.value
    end