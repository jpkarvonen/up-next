Rails.application.routes.draw do
  get 'tv/popular'
  get 'tv/show/:id' => "tv#show", :as => :show_tv_with_parameter
  get 'tv/search'

  root 'tv#popular'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
