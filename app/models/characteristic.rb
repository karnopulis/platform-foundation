class Characteristic < ApplicationRecord
  belongs_to :product
  belongs_to :property, :autosave => true
  accepts_nested_attributes_for :property
 
  
  def autosave_associated_records_for_property
    # Find or create the author by name
    puts "======"
    if new_prop = Property.find_by_title(property.title)
      self.property = new_prop
    else
      self.property.save!
    end
  end
  

  
end
