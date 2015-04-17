EdxThird::Application.routes.draw do

  root :to => 'groups#index'

  resources :groups do
    resources :products
  end

end
