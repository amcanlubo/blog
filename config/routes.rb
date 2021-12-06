Rails.application.routes.draw do
  
  devise_for :users
  root "articles#index"
  
  resources :articles do
    resources :comments
  end

  resources :categories do
    # match '/tasks/complete/:id' => 'tasks#complete', as: 'complete_task', via: :put 
    resources :tasks
    # get '/today' => 'tasks#today'
  end

  get '/today' => 'tasks#today'
end
                                                                                                          