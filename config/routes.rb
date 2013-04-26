DemoApp::Application.routes.draw do
  get '/classrooms/getinfo' => 'classrooms#getinfo'
  get 'classrooms/chart/:user_id' => 'classrooms#chart'
  get 'sms/' => 'sms#create'
  root :to => "static_pages#home"
  get 'calls/create/:assignment_id' => 'calls#create'
  get 'classrooms/cancel' => 'classrooms#cancel'
  get 'users/cancel' => 'users#cancel'

  get '/demo' => 'classrooms#demo'
  resources :sessions, only: [:new, :create, :destroy]
  resources :lectures, :only => [:new, :create, :show]
  resources :questions, :users, :teachers, :user_answers, :user_lectures, :sms, :calls
  resources :classrooms do
    get 'assignments', :on => :member
    post 'assign', :on => :member
  end
  match '/signup',  to: 'teachers#new'
  match '/signin',  to: 'sessions#new'
  match '/new_classroom', to: 'classrooms#new_teacher_classroom'
  match '/signout', to: 'sessions#destroy', via: :delete

  match ':controller(/:action(/:id(.:format)))'
  match ':controller(/:action(.:format))'
end

