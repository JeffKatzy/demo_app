DemoApp::Application.routes.draw do

  get 'sms/' => 'sms#create'
  root :to => "static_pages#home"
  get 'calls/create/:assignment_id' => 'calls#create'

  # Need this GET alias because Twilio call callback url doesn't seem to POST
  get 'calls/create' => 'calls#create', :as => 'create_call'

  resources :sessions, only: [:new, :create, :destroy]
  resources :lectures, :only => [:new, :create, :show]
  resources :questions, :users, :teachers, :user_answers, :user_lectures, :sms, :calls, :lessons


  resources :classrooms do
    get 'assignments', :on => :member
    post 'assign', :on => :member
  end
  get 'classrooms/cancel' => 'classrooms#cancel'
  get '/classrooms/getinfo' => 'classrooms#getinfo'
  get 'classrooms/chart/:user_id' => 'classrooms#chart'
  get '/demo' => 'classrooms#demo'
  match '/new_classroom', to: 'classrooms#new_teacher_classroom'

  get 'users/cancel' => 'users#cancel'
  match '/signup',  to: 'teachers#new'
  match '/signin',  to: 'sessions#new'
  delete '/login' => 'sessions#destroy'
  match '/signout', to: 'sessions#destroy', via: :delete

  match ':controller(/:action(/:id(.:format)))'
  match ':controller(/:action(.:format))'
end

