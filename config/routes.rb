Rails.application.routes.draw do
 
  namespace :public do
    get 'cart_items/index'
  end
  namespace :admin do
    get 'orders/show'
  end
  namespace :public do
    root to: 'homes#top'
    get 'customers/my_page' => 'customers#show'
    resources :customers, only: [:edit, :update]
    get 'customer/unsubscribe'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :create, :destroy]
  end

  namespace :admin do
    root to: 'homes#top'
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end
  

  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
