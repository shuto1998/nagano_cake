Rails.application.routes.draw do

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
  end
  
  namespace :public do
    get 'homes/top'
    get 'homes/about'
    resources :customers,only:[:show,:edit]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
