json.images do
    json.array! @object do |nc|
            json.id nc.id
            json.position nc.position
            json.filename nc.filename
            json.url nc.url
            json.original_url nc.original_url
            json.thumb_url nc.thumb_url
            json.size nc.size
            json.product_id nc.product_id
    end
end