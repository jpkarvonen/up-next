require 'rails_helper'

RSpec.describe MovieController, type: :controller do

  describe "GET #popular" do
    it "returns http success" do
      get :popular
      expect(response).to have_http_status(:success)
    end

    let(:popular_results) { ::Tmdb.get_pop_movie}

    it "responds with JSON hash containing search results" do
      expect(popular_results).to be_kind_of(Hash)
      expect(popular_results).to include("page" => 1)
    end
  end

  describe "GET #show" do
    before do
      get :show, params: { id: 320288 }
    end

    it "renders the #show view" do
      expect(response).to render_template :show
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    let(:movie_details) { ::Tmdb.get_movie_details(320288) }

    it "response with JSON hash containing expected Movie Details" do
      expect(movie_details).to be_kind_of(Hash)
    end

  end

  describe "GET #search" do
    it "returns http success" do
      get :search
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    let(:search_results) { ::Tmdb.search_movie("sample")}

    it "responds with JSON hash containing search results" do
      expect(search_results).to be_kind_of(Hash)
    end
  end
end
