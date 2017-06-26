class NewsController < ApplicationController
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  def index
    @top_collection = Collection.find_by parent: nil
    @news = News.all.order(created_at: :desc)
    @top_news = @news.first(10)
    params[:per_page]==nil ? per_page=5 : per_page=params[:per_page]
    @news = @news.page(params[:page]).per(per_page)
  end

  # GET /news/1
  # GET /news/1.json
  def show
    @top_collection = Collection.find_by parent: nil
    @top_news = News.all.order(created_at: :desc).first(10)
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end
end
