DemoApp::Application.routes.draw do
  post "calls/create"
  post "calls/flow"
  post "calls/exception"
  root :to => "calls#index"

  resources :lectures, :only => [:new, :create, :show]

  match ':controller(/:action(.:format))'
  match ':controller(/:action(/:id(.:format)))'
end

