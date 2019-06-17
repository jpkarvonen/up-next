require 'rails_helper'

RSpec.describe TvController, type: :controller do

  describe "GET #popular" do
    it "returns http success" do
      get :popular
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    before do
      get :show, params: { id: 87108 }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      expect(response).to render_template :show
    end

    let(:tv_details) { ::Tmdb.get_tv_details(87108) }

    it "response with JSON hash containing expected TV Show Details" do
      expect(tv_details).to be_kind_of(Hash)
    end
  end

  describe "GET #search" do
    it "renders the #search view" do
      get :search
      expect(response).to render_template("search")
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    let(:search_results) { ::Tmdb.search_tv("sample")}

    it "response with JSON hash containing search results" do
      expect(search_results).to be_kind_of(Hash)
    end
  end
end
