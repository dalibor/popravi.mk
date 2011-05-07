  PopraviMk::Application.routes.draw do
  # devise routes
  devise_for :users

  resources :municipalities, :only => [:index]

  resources :problems, :only => [:index, :show, :new, :create] do
    resources :comments, :only => [:create]
  end

  resources :reports, :only => [:show]

  namespace :user do
    resources :problems do
      collection do
        post :take_ownership
      end
      resources :rates, :only => [:create, :update]
    end
  end

  resources :posts, :only => [:index, :show] do
    resources :comments, :only => [:create]
  end

  # root route
  root :to => "welcome#index"
  
  get 'android' => "welcome#android", :as => 'android'

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
    resources :attachments
    resources :api_keys
  end

  # moderator routes
  namespace :moderator do
    root :to => "welcome#index"
    resources :problems, :only => [:index, :show, :edit, :update] do
      member do
        put :approve
        put :activate
        put :solve
        put :invalidate
      end
    end
    resources :comments, :only => [:index, :show, :edit, :update, :destroy]
    resources :posts
  end

  scope :module => "municipality" do
    root :to => "welcome#index", :as => :municipality_root, :path => ":id"
    resources :posts, :path => ":municipality_id/posts", :as => :municipality_posts
    resources :problems, :path => ":municipality_id/problems", :as => :municipality_problems
  end




  # api routes
  namespace :api do
    namespace :v1 do
      resources :problems
      resources :categories, :only => [:index]
      resources :municipalities, :only => [:index]
    end

    namespace :v2 do
      resources :problems do
        member do
          put :update_status
        end
      end
      resources :categories, :only => [:index]
      resources :municipalities, :only => [:index]
      resources :comments, :only => [:index, :create]
      resource :session, :only => [:create]
    end
  end
end
