Rails.application.routes.draw do



  get 'admin/categories'            =>'api#fake'
  post 'api/:model/create_bulk'   =>'api#create_bulk'
  put 'api/:model/update_bulk'    =>'api#update_bulk'
  delete 'api/:model/delete_bulk' =>'api#delete_bulk'
  get 'api/:model'        => 'api#index'
  get 'api/:model/:id'    => 'api#show' 
  post 'api/:model/'      => 'api#create'
  put 'api/:model/:id'    => 'api#update'
  delete 'api/:model/:id' => 'api#delete'

  # post 'admin/:model/create_bulk'   =>'api#create_bulk'
  # put 'admin/:model/update_bulk'    =>'api#update_bulk'
  # delete 'admin/:model/delete_bulk' =>'api#delete_bulk'
  # get 'admin/:model'        => 'api#index'
  # get 'admin/:model/:id'    => 'api#show' 
  # post 'admin/:model/'      => 'api#create'
  # put 'admin/:model/:id'    => 'api#update'
  # delete 'admin/:model/:id' => 'api#delete'

  
  get 'client_account/show'

  get 'page/:name' => 'page#show'

  get 'blog/index' => 'blog#index'
  get 'blog' => 'blog#index'
  get 'blog/show/:id' => 'blog#show'

  get '/index' => 'main#index'
  get '' => 'main#index'
  resources :collection, only: [:show]
  # get 'collection' =>'collection#index'
  # get 'collection/:id' => 'collection#show'
  delete 'cart_items'=> 'cart_items#destroy'
  
  resources :cart_items, only: [:create, :update, :destroy, :index]
  resources :product, only: [:show]



end
