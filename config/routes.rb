ThatStatBook::Application.routes.draw do
  devise_for :users, :controllers => { :passwords => 'passwords', :registrations => 'registrations' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#welcome'

  get '/home' => 'users#dashboard', as: :user_dashboard
  get '/summary' => 'users#summary', as: :user_summary
  get '/feedback' => 'users#feedback', as: :feedback
  
  resources :users, only: [:show,:index,:destroy]
  resources :lessons, only: [:show,:index,:update,:destroy,:new,:create] do
    collection { post :sort }
    resources :questions, only: [:new,:create]
    resources :videos, only: [:new,:create]
    resources :learning_modules, only: [:index,:create,:new,:destroy]
  end
  
  resources :learning_modules, only: [:update]
  resources :quizzes, only: [:create,:show]
  resources :questions, only: [:show,:destroy,:update]
  resources :choices, only: [:show,:update]
  resources :answer_submissions, only: [:create]
  resources :video_views, only: [:create]
  
  resources :rosters, only: [:index,:show,:new,:update,:create]
  
  resources :class_requests, only: [:create, :index]
  
  resources :suggestions do
    get :autocomplete_school_school, :on => :collection
  end

  get '/questions/:id/update_learning_module/:learning_module_id' => 'questions#update_learning_module'

  get '/quizzes/:quiz_id/new-question' => 'questions#show_random_question', as: :random_question
  get '/quizzes/:quiz_id/incomplete' => 'quizzes#incomplete'
  get '/quizzes/:quiz_id/certificate' => 'quizzes#certificate', as: :certificate
  get '/quizzes/:id/feedback' => 'quizzes#feedback', as: :quiz_feedback
  
  get 'rearrange' => 'lessons#rearrange'
  
  get 'password-reset' =>'pages#password_reset', as: :password_reset
  
  post '/countdown' => 'quizzes#countdown'
  
  get '/questions/:id/delete_image' => 'questions#delete_image', as: :delete_question_image
  
  patch '/rosters/:id/add_students' => 'rosters#add_students', as: :add_students
  post '/rosters/:id/remove_student/:user_id' => 'rosters#remove_student', as: :remove_student  
  get '/rosters-prof/:prof_id' => 'rosters#get_rosters_by_prof' 
  
  get '/rosters/:roster_id/students/:student_id' => 'rosters#show_roster_student', as: :student_roster

  get '/class_requests/:id/accept' => 'class_requests#accept', as: :accept_class_request
  get '/class_requests/:id/reject' => 'class_requests#reject', as: :reject_class_request
  
  get '/professors' => 'users#professors_index', as: :professors
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
