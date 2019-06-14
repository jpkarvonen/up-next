Rails.application.routes.draw do
  get 'tv/popular'
  get 'tv/show/:id' => "tv#show", :as => :tv_show
  get 'tv/search/(:query/:page)' => 'tv#search', :as => :tv_search

  root 'tv#popular'
end
