PopraviMk::Application.routes.draw do
  # devise routes
  devise_for :users

  resources :problems, :only => [:index, :show, :new, :create] do
    resources :comments, :only => [:create]
  end

  resources :reports, :only => [:show]

  namespace :user do
    resources :problems do
      collection do
        post :take_ownership
      end
    end
  end


  resources :municipalities, :only => [:index, :show] do
    resources :problems, :only => [:index]
  end

  resources :posts, :only => [:index, :show] do
    resources :comments, :only => [:create]
  end

  # root route
  root :to => "welcome#index"

  # admin routes
  namespace :admin do
    root :to => "welcome#index"
    resources :categories do
      member do
        get :move_up
        get :move_down
      end
    end
    resources :countries
    resources :regions
    resources :municipalities
    resources :users
    resources :problems do
      collection do
        put :sent
      end
    end
    resources :comments
    resources :posts
  end

  # moderator routes
  namespace :moderator do
    root :to => "welcome#index"
    resources :problems, :only => [:index, :show] do
      member do
        put :approve
        put :activate
        put :solve
        put :invalidate
      end
    end
    #resources :comments
    #resources :posts
  end

  # api routes
  namespace :api do
    namespace :v1 do
      resources :problems do
        collection do
          post :photo
        end
      end
      resources :categories, :only => [:index]
      resources :municipalities, :only => [:index]
    end
  end
end
