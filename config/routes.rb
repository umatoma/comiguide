Rails.application.routes.draw do
  # -----------------------------------------------------
  # Home
  # -----------------------------------------------------
  root 'home#index'
  get :about, controller: :home
  get :contact, controller: :home
  get :terms, controller: :home

  # -----------------------------------------------------
  # Templates
  # -----------------------------------------------------
  resources :templates, only: [] do
    collection do
      get :checklist_colorpicker
    end
  end

  # -----------------------------------------------------
  # Users
  # -----------------------------------------------------
  devise_for :users, controllers: {
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    sessions:      'users/sessions',
    confirmations: 'users/confirmations'
  }

  resources :users, controller: 'users/restful', only: [:index, :show] do
    collection do
      get :mypage
      get :profile
    end
  end

  # -----------------------------------------------------
  # Comikets
  # -----------------------------------------------------
  resources :comikets, only: [:index, :show] do
    resources :ckigyos, only: [:index] do
      collection do
        get :ranking
      end
    end
    resources :ckigyo_checklists, only: [:index] do
      collection do
        get :create_map
        get :download
      end
    end
    resources :ccircle_checklists, only: [:index] do
      collection do
        get :create_map
        get :download
      end
    end
  end

  # -----------------------------------------------------
  # Careas
  # -----------------------------------------------------
  resources :careas, only: [:index] do
    resources :cblocks, only: [] do
      resources :clayouts, only: [:index]
    end
  end

  # -----------------------------------------------------
  # Ckigyos
  # -----------------------------------------------------
  resources :ckigyos, only: [:show] do
    collection do
      get :show_modal_template
    end
  end

  # -----------------------------------------------------
  # CkigyoChecklists
  # -----------------------------------------------------
  resources :ckigyo_checklists, only: [:create, :update, :destroy]

  # -----------------------------------------------------
  # CcircleChecklists
  # -----------------------------------------------------
  resources :ccircle_checklists, only: [:create, :update, :destroy]

  # -----------------------------------------------------
  # Comic1s
  # -----------------------------------------------------
  resources :comic1s, only: [:index, :show] do
    resources :c1circles, only: [:index] do
      collection do
        get :search
      end
    end
    resources :c1circle_checklists, only: [:index] do
      collection do
        get :create_map
        get :download
      end
    end
  end

  # -----------------------------------------------------
  # C1blocks
  # -----------------------------------------------------
  resources :c1blocks, only: [:index] do
    resources :c1layouts, only: [:index]
  end

  # -----------------------------------------------------
  # C1circleChecklists
  # -----------------------------------------------------
  resources :c1circle_checklists, only: [:create, :update, :destroy]

  # -----------------------------------------------------
  # Notifications
  # -----------------------------------------------------
  resources :notifications, only: [:index, :show]

  # -----------------------------------------------------
  # Admin
  # -----------------------------------------------------
  namespace :admin do
    get :layouts, controller: :home
    resources :notifications, only: [:index, :show, :create, :update, :destroy]
    resources :users, only: [:index]
  end

  # -----------------------------------------------------
  # Api
  # -----------------------------------------------------
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [] do
        collection do
          post :sign_in
        end
      end
      resources :comikets, only: [] do
        resources :ckigyos, only: [:index]
        resources :ckigyo_checklists, only: [:index]
      end
      resources :careas, only: [:index]
      resources :cblocks, only: [] do
        resources :clayouts, only: [:index]
      end
      resources :ckigyo_checklists, only: [:create, :update, :destroy]
    end
  end
end
