class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id]).decorate
    @comments = @movie.comments.includes(:user).order('comments.created_at ASC')
    @comment = Comment.new
    @user_comment = Comment.find_by(movie_id: @movie.id, author_id: current_user.id) if current_user.present?
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_to :back, notice: 'Email sent with movie info'
  end

  def export
    file_path = 'tmp/movies.csv'
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: 'Movies exported'
  end
end
