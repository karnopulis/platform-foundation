Rails.application.routes.draw do
  devise_scope :admin do
      get 'admin/admins', to: 'admin/base#index'
      get 'admin/admins/:id/edit', to: 'admin/registrations#edit'
      put 'admin/:id', to: 'admin/registrations#update'
      patch 'admin/:id', to: 'admin/registrations#update'
      delete 'admin/admins/:id', to: 'admin/registrations#remove'

  devise_for :admin,  controllers: { registrations: "admin/registrations",sessions: "admin/sessions" ,passwords: "admin/passwords",confirmations: "admin/confirmations"  }

  end
   namespace :admin do
     resources :news
   end
  # devise_scope :admin do
  #   get 'login', to: 'admin/sessions#new'
  # end
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

    resources :news, only: [:show,:index]


  get '/index' => 'main#index'
  get '' => 'main#index'
  resources :collection, only: [:show]
  # get 'collection' =>'collection#index'
  # get 'collection/:id' => 'collection#show'
  delete 'cart_items'=> 'cart_items#destroy'
  
  resources :cart_items, only: [:create, :update, :destroy, :index]
  resources :product, only: [:show]



end
