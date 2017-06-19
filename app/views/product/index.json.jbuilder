json.products do
    json.array! @object  do |nc|
#        json.product do
                    json.id nc.id
                    json.title nc.title
                    json.sort_weight nc.sort_weight.to_f
                    json.properties do
                        json.array! nc.try(:properties) do  |s| 
                            json.id s.id
                            json.title s.title
                        end
                    end

                    json.characteristics do
                        json.array! nc.try(:characteristics) do  |s| 
                            json.id s.id
                            json.property_id s.property_id
                            json.title s.title
                        end
                    end
                    json.variants do
                        json.array! nc.try(:variants) do |ev|
        #                    json.variant do
                                json.id ev.id
                                json.sku ev.sku
                                json.quantity ev.quantity
                                ev.prices.each do |pc|
                                    if pc.value.zero?
                                        json.set! pc.name,nil 
                                    else
                                        json.set! pc.name,pc.value
                                    end
                                end
        #                    end
                            
                        end
                    end 
                    json.images do
                    json.array! nc.try(:images) do |ei|
                        
                        json.id ei.id
                        json.position ei.position
                        json.filename ei.filename
                        json.url ei.url
                        json.original_url ei.original_url
                        json.thumb_url ei.thumb_url
                    end
                end
#        end
    end
end