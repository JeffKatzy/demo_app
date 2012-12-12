DemoApp::Application.routes.draw do
  get "teachers/new"

  get "static_pages/home"
  get "static_pages/help"

  
  post "calls/create"
  post "calls/flow"
  post "calls/exception"
  root :to => "static_pages#home"

  resources :sessions, only: [:new, :create, :destroy]
  resources :lectures, :only => [:new, :create, :show]
  resources :questions
  
  resources :classrooms do
    resources :users
  end

  resources :teachers

  match '/signup', to: 'users#new'  
  
  match ':controller(/:action(/:id(.:format)))'
  match ':controller(/:action(.:format))'
end

