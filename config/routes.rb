Rails.application.routes.draw do
  get 'movie/popular'
  get 'movie/show/:id' => "movie#show", :as => :movie_show
  get 'movie/search/(:query/:page)' => 'movie#search', :as => :movie_search

  get 'tv/popular'
  get 'tv/show/:id' => "tv#show", :as => :tv_show
  get 'tv/search/(:query/:page)' => 'tv#search', :as => :tv_search

  root 'tv#popular'
end
