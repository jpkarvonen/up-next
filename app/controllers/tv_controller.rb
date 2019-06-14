class TvController < ApplicationController
  before_action :tv

  def popular
    @pop_tv = ::Tmdb.get_pop_tv
  end

  def show
    @tv_details = ::Tmdb.get_tv_details(params[:id])
  end

  def search
    @page = params[:page]
    @query = params[:query]
    @search_results = ::Tmdb.search_tv(@query, @page)
    @page_number = @page.to_i
    @previous = @page_number >= 2 ? @page_number - 1 : @page_number = 1
    @total_pages = @search_results["total_pages"] ? @search_results["total_pages"] : @total_pages =  0
    @next = @page_number + 1
    @next <= @total_pages ? @page_number + 1 : @next = @total_pages
  end

  def tv
    @tv = true
  end
end
