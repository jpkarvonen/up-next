require 'httparty'
require 'json'

module Tmdb
  class << self
    def get_api
      Rails.application.credentials.api[:key]
    end

    def base
      "https://api.themoviedb.org/3/"
    end

    #TV API CALLS
    def get_pop_tv
      response = HTTParty.get("#{base}trending/tv/day?api_key=#{get_api}")
      JSON.parse(response.body)
    end
  end
end
