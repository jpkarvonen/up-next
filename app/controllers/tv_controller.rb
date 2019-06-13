class TvController < ApplicationController
  def popular
    @pop_tv = ::Tmdb.get_pop_tv
  end

  def show
    @tv_details = ::Tmdb.get_tv_details(params[:id])
  end

  def search
    @search_results = ::Tmdb.search_tv(params[:query], params[:page])
  end
end
