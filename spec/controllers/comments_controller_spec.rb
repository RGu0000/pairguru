require "rails_helper"

RSpec.describe CommentsController do
  include Devise::Test::ControllerHelpers
  let!(:user) { create(:user, :user_id_1) }
  let!(:genre) { create(:genre, :with_movies) }
  let(:movie) { Movie.first }

  context 'user logged in' do
  before { sign_in(user) }

    describe 'POST #create' do
      subject do
        post :create, params: {
          movie_id: movie.id,
          comment: { message: message }
        }
      end

      context 'user adds valid comment' do
        let!(:message) { "valid message" }

        it { expect { subject }.to change { Comment.count }.by(1) }
        it { should redirect_to(movie) }
      end

      context 'user adds empty comment' do
        let!(:message) { "" }

        it { expect { subject }.to change { Comment.count }.by(0) }
        it { should redirect_to(movie) }
      end

      context 'user adds duplicate' do
        let!(:comment) { create(:comment, :author_id_1, :movie_id_1) }
        let!(:message) { "valid message" }

        it { expect { subject }.to change { Comment.count }.by(0) }
        it { should redirect_to(movie) }
      end
    end

    describe 'DELETE #destroy' do
      let!(:comment) { create(:comment, :author_id_1, :movie_id_1) }
      subject do
        delete :destroy, params: {
          movie_id: movie.id,
          id: id
        }
      end

      context 'user deletes his comment' do
        let!(:id) { comment.id }
        it { expect { subject }.to change { Comment.count }.by(-1) }
        it { should redirect_to(movie) }
      end

      context 'user deletes not his comment' do
        let!(:comment2) { create(:comment, :author_id_2, :movie_id_1) }
        let!(:id) { comment2.id }

        it { expect { subject }.to change { Comment.count }.by(0) }
        it { should redirect_to(movie) }
      end
    end
  end

  context 'user not logged in' do
    describe 'POST #create' do
      subject do
        post :create, params: {
          movie_id: movie.id,
          comment: { message: message }
        }
      end

      context 'not logged user tries to add comment' do
        let!(:message) { "valid message" }

        it { expect { subject }.to change { Comment.count }.by(0) }
        it { should redirect_to('/users/sign_in') }
      end
    end

    describe 'DELETE #destroy' do
      let!(:comment) { create(:comment, :author_id_1, :movie_id_1) }
      subject do
        delete :destroy, params: {
          movie_id: movie.id,
          id: id
        }
      end

      context 'not logged user tries to delete comment' do
        let!(:id) { comment.id }
        it { expect { subject }.to change { Comment.count }.by(0) }
        it { should redirect_to('/users/sign_in') }
      end
    end
  end
end
