Rails.application.routes.draw do
 
 devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  namespace :public do
    root to: 'homes#top'
    get 'customers/my_page' => 'customers#show'
    resources :customers, only: [:edit, :update] do
      collection do
        get :unsubscribe
      end
    end
    resources :items, only: [:index, :show]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all', as: 'cart_items_destroy_all'
    resources :cart_items, only: [:index, :update, :create, :destroy]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :index, :show, :create] do
      collection do
        get :complete
        get :comfirm
        post :comfirm
      end
      member do
      end
    end
    #get 'orders/complete'
    #post 'orders/comfirm'
    #get 'orders/comfirm'
  end

  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end
  


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
