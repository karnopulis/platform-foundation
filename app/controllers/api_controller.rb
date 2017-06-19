class ApiController < ApplicationController
  ALLOW= [Collection,Product,Collect,Variant,Property,Image]
  protect_from_forgery with: :null_session
  http_basic_authenticate_with name: "txl3sKWtBS_mEukgFVxF_g", password: "8Vl0ekLdbJrrEpmEdkmLRw"

#  before_action :destroy_session

  def index
    model=params[:model]
    begin
      model =model.singularize.classify
      throw "not allowed or not found model: "+model.to_s if ALLOW.include? model
      puts "not allowed or not found model: "+model.to_s if ALLOW.include? model
      params[:per_page]==nil ? per_page=2000 : per_page=params[:per_page]
      puts per_page
      @object = model.constantize.all.order(:id).page(params[:page]).per(per_page)
    rescue Exception => exc
#      respond_to do |format|
#          format.html { render :new }
        puts exc.message
        puts "========================"
#          format.json { render :template =>"api/error" }
        e= {:status=>"error",:error=>exc.message}
        render :inline => e.to_json, :status => :internal_server_error
          return
#      end 
            
    end
#    ApplicationController.new.view_context.render( :partial => model+"/_index", :locals => { model.pluralize =>  object})
    respond_to do |format|
#        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :template => model.underscore+"/index", :status => :ok  }

    end
  end

  def show
    
  end

  def create
    model=params[:model]
#    puts model
    begin
      model =model.singularize.classify
      throw "not allowed or not found model: "+model.to_s if ALLOW.include? model
      puts "not allowed or not found model: "+model.to_s if ALLOW.include? model
      params.permit!
      @object = params.fetch( model.underscore, {} )
      puts @object.to_s
      puts "+======================+"
      @result = model.constantize.create(@object)
      respond_to do |format|
#        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :template => model.underscore+"/show", :status => :created  }

      end
    rescue Exception => exc 
#      respond_to do |format|
#          format.html { render :new }
        puts exc.message
        puts "========================"
        e= {:status=>"error",:error=> exc.message}
        render :inline => e.to_json, :status => :internal_server_error
          return
    end
    
  end

  def update
    model=params[:model]
    id =params[:id]
#    puts model
    begin
      model =model.singularize.classify
      throw "not allowed or not found model: "+model.to_s if ALLOW.include? model
      puts "not allowed or not found model: "+model.to_s if ALLOW.include? model
      
      @object = model.constantize
      # .find_by id: id
      # throw "not found id: "+ model.to_s + id.to_s  if @object.nil?
      params.permit!
      @mhash = params.fetch( model.underscore, {} )
      @result = @object.update(id, @mhash)
      respond_to do |format|
        

        format.json { render :template => model.underscore+"/show", :status => :ok  }
      end
    rescue Exception => exc 
#      respond_to do |format|
#          format.html { render :new }
        puts exc.message
        puts "========================"
        e= {:status=>"error",:error=> exc.message}
        render :inline => e.to_json, :status => :internal_server_error
          return
    end
    
  end

  def delete
    model=params[:model]
    id =params[:id]
#    puts model
    begin
      model =model.singularize.classify
      throw "not allowed or not found model: "+model.to_s if ALLOW.include? model
      puts "not allowed or not found model: "+model.to_s if ALLOW.include? model
      
      @object = model.constantize.find_by id: id
      throw "not found id: "+ model.to_s + id.to_s  if @object.nil?
      @object.destroy
      respond_to do |format|
        

        format.json {render :inline => {:status=>"ok",:id => id }.to_json, :status => :ok }

      end
    rescue Exception => exc 
#      respond_to do |format|
#          format.html { render :new }
        puts exc.message
        puts "========================"
        e= {:status=>"error",:error=> exc.message}
        render :inline => e.to_json, :status => :internal_server_error
          return
    end
  end

  def create_bulk
  end

  def update_bulk
    model=params[:model]
#    puts model
    begin
      model =model.singularize.classify
      throw "not allowed or not found model: "+model.to_s if ALLOW.include? model
      puts "not allowed or not found model: "+model.to_s if ALLOW.include? model
      
      @object = model.constantize
      # .find_by id: id
      # throw "not found id: "+ model.to_s + id.to_s  if @object.nil?
      params.permit!
      @mhash = params.fetch( model.pluralize.underscore, {} )
      result = @object.update(@mhash.collect{ |d| d[:id]} , @mhash)
      #@result = @object.update([ 1,30,41,4543252,65] , @mhash)
      puts result.to_json
      respond_to do |format|
        

        format.json { render :inline  => result.to_json, :status => :ok  }
      end
    rescue Exception => exc 
#      respond_to do |format|
#          format.html { render :new }
        puts exc.message
        puts "========================"
        e= {:status=>"error",:error=> exc.message}
        render :inline => e.to_json, :status => :internal_server_error
          return
    end
    
  end

  def delete_bulk
  end
  
  def fake
    e= {"categories" =>[{"created_at"=>"2012-04-02T11:21:26+04:00","id"=>376433,"parent_id"=>"null","position"=>0,"title"=>"jhjkhgdf","updated_at"=>"2012-04-02T11:21:26+04:00"}]}
    render :inline => e.to_json, :status => :ok
  end
end
