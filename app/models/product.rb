class Product < ApplicationRecord
    has_many :variants,dependent: :destroy
    has_many :collects, dependent: :delete_all

    has_many :collections , :through => :collects
    has_many :images,dependent: :destroy
    has_many :characteristics, dependent: :delete_all
    has_many :properties , :through => :characteristics


    accepts_nested_attributes_for :variants ,:properties,:characteristics , allow_destroy: true

    before_save :generate_permalink
    BRIEF =["Формат","Отделка","Код цены","конструктив","Размер","Количество в упаковке"]
    FULL =["Формат","Отделка","Код цены","конструктив","Размер","Количество в упаковке"]
    KU ="Количество в упаковке"
 
     def generate_permalink
        self.permalink  ||= (self.title+"-"+self.variants.try(:first).try(:sku)).to_slug.transliterate(:russian).normalize.to_s
        sinonims = Product.where(:permalink => self.permalink).where.not(:id => self.id).count
        self.permalink += self.id.to_s if sinonims >0
#        puts self.attributes
#       puts " ==="
     end
     
    def brief_characteristics
        self.characteristics.where("properties.title"=> BRIEF).where.not(
            "characteristics.title"=> "").where.not(
            "characteristics.title"=> nil).includes(:property).references(:property).pluck("properties.title","characteristics.title")
    end
    def full_characteristics
        self.characteristics.where("properties.title"=> FULL).where.not(
            "characteristics.title"=> "").where.not(
            "characteristics.title"=> nil).includes(:property).references(:property).pluck("properties.title","characteristics.title")
    end
    
    def extract_qu_array(array)
        array.select {|v| v[0]==self.id && v[1]==KU}.first.try(:[],2) || 1
    end
    
    def extract_qu_db()
        self.properties.where(:title => KU).first.characteristics.first.title
    end
  
    def self.regenerate_permalinks
        Product.all.each do |c|
            c.permalink=nil
            c.generate_permalink
            c.save
        end
    end
    
    
    def prods_by_collection
        products_scope =self.products.order(sort_weight: :desc).joins(join_sql_string)
        @products =products_scope.page(params[:page]).per(per_page)
        
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
