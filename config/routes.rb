ActionController::Routing::Routes.draw do |map|
  # devise routes
  map.devise_for :users

  map.resources :problems, :collection => {:ownership => :get, :take_ownership => :post, :my => :get}

  # root route
  map.root :controller => "welcome"

  # admin routes
  map.namespace :admin do |admin|
    admin.root :controller => "welcome"
    admin.resources :categories
    admin.resources :countries
    admin.resources :regions
    admin.resources :municipalities
    admin.resources :users
    admin.resources :problems
  end

  # api routes
  map.namespace :api do |api|
    api.namespace :v1 do |v1|
      v1.resources :problems, :collection => {:photo => :post}
    end
  end
end
