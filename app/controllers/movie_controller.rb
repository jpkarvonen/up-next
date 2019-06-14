class MovieController < ApplicationController
  before_action :movie

  def popular
    @pop_movie = ::Tmdb.get_pop_movie
  end

  def show
    @movie_details = ::Tmdb.get_movie_details(params[:id])
  end

  def search
    @page = params[:page]
    @query = params[:query]
    @search_results = ::Tmdb.search_movie(@query, @page)
    @page_number = @page.to_i
    @previous = @page_number >= 2 ? @page_number - 1 : @page_number = 1
    @total_pages = @search_results["total_pages"] ? @search_results["total_pages"] : @total_pages =  0
    @next = @page_number + 1
    @next <= @total_pages ? @page_number + 1 : @next = @total_pages
  end

  def movie
    @movie = true
  end
end
