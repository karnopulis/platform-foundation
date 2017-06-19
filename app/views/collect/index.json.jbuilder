json.collects do
    json.array! @object  do |nc|
            json.id nc.id
            json.collection_id nc.collection_id
            json.product_id nc.product_id
            json.position nc.position

    end
 end