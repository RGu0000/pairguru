class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: %i[create destroy]
  # before_action :check_if_already_liked!, only: %i[create]

  def create
    @like = @movie.likes.new(like_params)
    initialize_like
    if @like.save
      flash[:notice] = "Added like to #{@movie.title}."
    else
      flash[:danger] = 'Failed to add new like.'
    end
    redirect_to @movie
  end

  def destroy
    like = @movie.likes.find(params[:id])
    if like.user_id == current_user.id && like.destroy
      flash[:notice] = 'Unliked the movie'
    else
      flash[:danger] = 'Failed to unlike a movie. Try again.'
    end
    redirect_to @movie
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def like_params
    params.permit(:user_id, :movie_id)
  end

  def initialize_like
    @like.user_id = current_user.id
    @like.movie_id = @movie.id
  end
end
