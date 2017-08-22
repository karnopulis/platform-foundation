#1
class CollectionController < ApplicationController
FILTER= ["Формат","Отделка","текст","Код цены"]
BRIEF =["Формат","Отделка","Код цены","конструктив","Размер","Количество в упаковке"]

  def index
    
  end
  
  def show
  @top_collection = Collection.find_by parent: nil
    @collection = Collection.find_by permalink: params[:id]||"parent"
    if @collection.nil? 
      raise ActionController::RoutingError.new('Not Found')
    end
    params[:per_page]==nil ? per_page=36 : per_page=params[:per_page]
    if @top_collection==@collection
      products_scope = Product.all.order(sort_weight: :desc).joins(join_sql_string)
      @products = products_scope.page(params[:page]).per(per_page)
    else
      products_scope =@collection.products.order(sort_weight: :desc).joins(join_sql_string)
      @products =products_scope.page(params[:page]).per(per_page)
    end
    @properties =[]
    sel_props =Property.where(:title => FILTER).order(:id) 
    sel_props.each do |pr|
            @properties << {:title => pr.title, :characteristics =>  Characteristic.where(:product_id => products_scope.ids).where(:property_id => pr.id).group(:title).count }
    end
    @ps1 = @products.ids
    char_join = "RIGHT JOIN `characteristics` ON `characteristics`.`product_id` = `products`.`id` AND `characteristics`.`property_id` IN ("+
                Property.where(:title => BRIEF).order(:id).ids.join(",") +")"
    prop_join = " LEFT JOIN `properties` ON `characteristics`.`property_id` = `properties`.`id` "
    @np= products_scope.where("products.id" => @products.map{|v| v.id}).
                        joins(char_join).where.not("characteristics.title" => "").joins(prop_join).
                        order("products.id","characteristics.property_id").
                        pluck("products.id","properties.title","characteristics.title")
    @cart_item = current_cart.cart_items.new
      puts @collection.title
    puts @top_collection.subcollections.first.title
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
