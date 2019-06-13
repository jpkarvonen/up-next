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

    def search_tv(query, page=1)
      response = HTTParty.get("#{base}search/tv?api_key=#{api_key}&language=en-US&query=#{query}&page=#{page}")
      JSON.parse(response.body)
    end
  end
end
