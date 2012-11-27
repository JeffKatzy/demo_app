DemoApp::Application.routes.draw do
  match ':controller(/:action(.:format))'
  post "calls/create"
  post "calls/flow"
  post "calls/exception"
  root :to => "users#index"

  resources :lectures, :only => [:new, :create, :show]
  resources :questions
  resources :users


  match '/signup', to: 'users#new'  
  
  match ':controller(/:action(/:id(.:format)))'
end

