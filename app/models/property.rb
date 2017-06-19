class Property < ApplicationRecord
    has_many :characteristics , inverse_of: :property, dependent: :delete_all

    has_many :products  , :through => :characteristics
#    validates_uniqueness_of :title

#     def self.create(attributes = nil, options = {}, &block)
#         if attributes.is_a?(Array)
#           attributes.collect { |attr| create(attr, options, &block) }
#         else
# #          object = new(attributes, options)
#             puts attributes
#           object = find_by(attributes) || create(attributes, &block)
#             puts object
# #          yield(object) if block_given?
# #          object.save
#           object
#         end
#       end

end
