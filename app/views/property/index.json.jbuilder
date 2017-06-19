json.properties do
    json.array! @object do |nc|
            json.id nc.id

            json.position nc.position
            json.title nc.title
        
    end
end