class MainController < ApplicationController
#  layout "main"  
  def index
    @top_collection = Collection.find_by parent: nil
  end
end
