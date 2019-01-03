Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root :to => redirect('/medications')
  resources :medications do
    resources :medication_times, :path => :times, :as => :times, :except => [ :index ]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
