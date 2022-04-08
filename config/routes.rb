Rails.application.routes.draw do

   scope module: :public do

    get '/' => 'homes#top'
    get '/about' => 'homes#about'
    get 'customers/my_page' => 'customers#show'
    get '/customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch '/customers/withdrawal' => 'customers#withdrawal', as: 'withdrawal'
    # get 'items' => 'admin::items#index'
    resource :customers,only:[:edit,:update]
    resources :items,only:[:index,:show]
    resources :cart_items,only:[:index,:create,:new,:destroy,:update] do
     collection do
        delete 'destroy_all'
      end
     end
    resources :orders,only:[:index,:show,:new,:create] do
     collection do
        get 'comfirm'
        get 'complete'
      end
    end
    resources :addresses,only:[:index,:edit,:update,:create,:new,:destroy]

  end
# 顧客用
# URL /customers/sign_in ...

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  root :to =>  'public/homes#top'

 namespace :admin do
   resources :genres, only: [:new,:create,:index,:edit,:update]
   resources :items,only:[:new,:index,:show,:edit,:update,:create]
   resources :customers,only:[:show,:index,:edit,:update]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
