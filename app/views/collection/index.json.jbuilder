json.collections do
    json.array! @object do |nc|
#        json.collection do
            json.id nc.id

            json.sort_type nc.sort
            json.position nc.position
            json.title nc.title
            json.parent_id nc.attributes["parent"]
#        end
    end
end