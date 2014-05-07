ThatStatBook::Application.routes.draw do
  devise_for :users, :controllers => { :passwords => 'passwords', :registrations => 'registrations' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#welcome'

  get '/home' => 'users#dashboard', as: :user_dashboard
  get '/summary' => 'users#summary', as: :user_summary

  resources :users, only: [:show,:index]
  resources :lessons, only: [:show,:index,:update,:destroy,:new,:create] do
    collection { post :sort }
    resources :questions, only: [:new,:create]
    resources :videos, only: [:new,:create]
  end
  resources :quizzes, only: [:create,:show]
  resources :questions, only: [:show,:destroy,:update]
  resources :choices, only: [:show,:update]
  resources :answer_submissions, only: [:create]
  resources :video_views, only: [:create]
  
  resources :suggestions do
    get :autocomplete_school_school, :on => :collection
  end

  get '/quizzes/:quiz_id/new-question' => 'questions#show_random_question'
  get '/quizzes/:quiz_id/incomplete' => 'quizzes#incomplete'
  get '/quizzes/:quiz_id/certificate' => 'quizzes#certificate', as: :certificate
  
  get 'rearrange' => 'lessons#rearrange'
  
  get 'password-reset' =>'pages#password_reset', as: :password_reset
  
  post '/countdown' => 'quizzes#countdown'
  
  get '/questions/:id/delete_image' => 'questions#delete_image', as: :delete_question_image



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
