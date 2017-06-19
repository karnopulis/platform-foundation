class Collection < ApplicationRecord
     has_many :collects ,dependent: :delete_all
     has_many :products , :through => :collects
     
     before_save :generate_permalink
     FILTER= ["Формат","Отделка","текст","Код цены"]
    BRIEF =["Формат","Отделка","Код цены","конструктив","Размер","Количество в упаковке"]
     
     def generate_permalink
         st =self.parent.try(:title) if self.parent.try(:parent) != nil 
         puts st
        self.permalink  ||= (st.to_s+"-"+ self.title).to_slug.transliterate(:russian).normalize.to_s
        sinonims = Collection.where(:permalink => self.permalink).where.not(:id => self.id).count
        self.permalink += self.id.to_s if sinonims >0
#        puts self.attributes
#       puts " ==="
     end
    
     def self.regenerate_permalinks
        Collection.all.each do |c|
            c.permalink=nil
            c.generate_permalink
            c.save
        end
     end
     
     def parent
        Collection.find_by_id(self.attributes["parent"]) 
     end
     def subcollections
         Collection.where(:parent => self.id)
     end
     
     def  properties
         Property.all
         
     end
     
     def to_param
        return "#{self.permalink}"
     end
     
     
     def prods_by_collection
        products_scope =self.products.order(sort_weight: :desc).joins(join_sql_string)
#        @products =products_scope.page(params[:page]).per(per_page)
        
    end
    
    
     def join_sql_string
      prop = Property.where(:title => FILTER).order(:id).pluck("id")
      chars=params[:characteristics]
      return nil if chars.blank?
      join_sql=""
      prop.each_with_index do |p,i|
        
         join_sql+= (" INNER JOIN `characteristics` AS j" + i.to_s + " ON `j" + i.to_s + "`.`product_id` = `products`.`id` AND `j" + i.to_s + "`.`title` = '" + chars[i] + "' AND `j" + i.to_s + "`.`property_id` = '" + prop[i].to_s + "'" ) unless chars[i].blank?
      end
      join_sql
  end
    

end
