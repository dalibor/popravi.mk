ActionController::Routing::Routes.draw do |map|
  # devise routes
  map.devise_for :users

  map.resources :problems, :collection => {:take_ownership => :post, :my => :get} do |problem|
    problem.resources :comments, :only => [:create]
  end

  # root route
  map.root :controller => "welcome"

  # admin routes
  map.namespace :admin do |admin|
    admin.root :controller => "welcome"
    admin.resources :categories, :member => {:move_up => :get, :move_down => :get}
    admin.resources :countries
    admin.resources :regions
    admin.resources :municipalities
    admin.resources :users
    admin.resources :problems
    admin.resources :comments
  end

  # api routes
  map.namespace :api do |api|
    api.namespace :v1 do |v1|
      v1.resources :problems, :collection => {:photo => :post}
      v1.resources :categories, :only => [:index]
      v1.resources :municipalities, :only => [:index]
    end
  end
end
