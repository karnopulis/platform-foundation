
                json.id @result.id
                json.title @result.title
                json.sort_weight @result.sort_weight.to_f
                    json.properties do
                        json.array! @result.try(:properties) do  |s| 
                            json.id s.id
                            json.title s.title
                        end
                    end

                    json.characteristics do
                        json.array! @result.try(:characteristics) do  |s| 
                            json.id s.id
                            json.property_id s.property_id
                            json.title s.title
                        end
                    end
                json.variants do
                    json.array! @result.try(:variants) do |ev|
    #                    json.variant do
                            json.id ev.id
                            json.sku ev.sku
                            json.quantity ev.quantity
                            ev.prices.each do |pc|
                                json.set! pc.name,pc.value
                            end
    #                    end
                        
                    end
                end  
                json.images do
                    json.array! @result.try(:images) do |ei|
                        
                        json.id ei.id
                        json.position ei.position
                        json.filename ei.filename
                        json.url ei.url
                        json.size ei.size
                        json.original_url ei.original_url
                        json.thumb_url ei.thumb_url
                    end
                end