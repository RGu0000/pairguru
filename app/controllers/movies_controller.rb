class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info, :update]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments.includes(:user).order('comments.created_at ASC')
    @comment = Comment.new
    @user_comment = Comment.find_by(movie_id: @movie.id, author_id: current_user.id) if current_user.present?
    @user_like = Like.find_by(movie_id: @movie.id, user_id: current_user.id) if current_user.present?
    @user_rating = Rating.find_by(movie_id: @movie.id, user_id: current_user.id) if current_user.present?
    @average_rating = RatingsQuery.new(@movie.id).average_rating
  end

  def update
    @movie = Movie.find(params[:id])
    get_params
    @movie.title = get_params[:title]
    @movie.description = get_params[:description]
    @movie.genre_id = get_params[:genre_id]
    # binding.pry
    if @movie.save
      flash[:notice] = "You have updated on #{@movie.title}."
    else
      flash[:danger] = "Operation failed. Try again"
    end
    redirect_to @movie
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

  private

  def get_params
    params.require(:movie).permit(:title, :description, :genre_id)
  end

  def update_movie_att

  end
end
