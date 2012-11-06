DemoApp::Application.routes.draw do
  post "calls/create"
  post "calls/flow"
  post "calls/exception"
  root :to => "calls#index"
end
