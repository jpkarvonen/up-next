class TvController < ApplicationController
  def popular
    @pop_tv = ::Tmdb.get_pop_tv
  end

  def show
  end

  def search
    @search_results = ::Tmdb.search_tv(params[:query], params[:page])
  end
end
