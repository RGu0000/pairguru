require "rails_helper"

RSpec.describe MoviesController do
let!(:genre) { create(:genre, :with_movies) }


  describe "GET #index" do
    subject { get :index }
    it { expect(subject.status).to eq(200) }
  end

  describe "GET #show" do
    subject { get :show, params: { id: Movie.first.id } }
    it { expect(subject.status).to eq(200) }
  end
end
