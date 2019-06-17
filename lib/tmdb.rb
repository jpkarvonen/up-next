require 'httparty'
require 'json'

module Tmdb
  class << self
    def api_key
      Rails.application.credentials.api[:key]
    end

    def base
      "https://api.themoviedb.org/3/"
    end

    #TV API CALLS
    def get_pop_tv
      response = HTTParty.get("#{base}trending/tv/day?api_key=#{api_key}")
      JSON.parse(response.body)
    end

    def get_tv_details(id)
      response = HTTParty.get("#{base}tv/#{id}?api_key=#{api_key}")
      JSON.parse(response.body)
    end

    def search_tv(query, page=1)
      response = HTTParty.get("#{base}search/tv?api_key=#{api_key}&language=en-US&query=#{query}&page=#{page}")
      JSON.parse(response.body)
    end

    def get_tv_review(id)
      response = HTTParty.get("#{base}tv/#{id}/reviews?api_key=#{api_key}&language=en-US&page=1")
      JSON.parse(response.body)
    end

    #MOVIE API CALLS
    def get_pop_movie
      response = HTTParty.get("#{base}movie/popular?api_key=#{api_key}&language=en-US&page=1")
      JSON.parse(response.body)
    end

    def get_movie_details(id)
      response = HTTParty.get("#{base}movie/#{id}?api_key=#{api_key}&language=en-US")
      JSON.parse(response.body)
    end

    def search_movie(query, page=1)
      response = HTTParty.get("#{base}search/movie?api_key=#{api_key}&language=en-US&query=#{query}&page=#{page}&include_adult=false")
      JSON.parse(response.body)
    end

    def get_movie_review(id)
      response = HTTParty.get("#{base}movie/#{id}/reviews?api_key=#{api_key}&language=en-US&page=1")
      JSON.parse(response.body)
    end

  end
end
