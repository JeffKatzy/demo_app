DemoApp::Application.routes.draw do
  get '/classrooms/getinfo' => 'classrooms#getinfo'
  root :to => "static_pages#home"

  get '/demo' => 'classrooms#demo'
  resources :sessions, only: [:new, :create, :destroy]
  resources :lectures, :only => [:new, :create, :show]
  resources :questions, :classrooms, :users, :teachers, :user_answers, :user_lectures

  match '/signup',  to: 'teachers#new'
  match '/signin',  to: 'sessions#new'
  match '/new_classroom', to: 'classrooms#new_teacher_classroom'
  match '/signout', to: 'sessions#destroy', via: :delete

  match ':controller(/:action(/:id(.:format)))'
  match ':controller(/:action(.:format))'
end

